-- [[ CORE ]]--

local MainModule = {Version = 1}
local PurchaseTable = {}

-- [[ CORE FUNCTIONS ]]--

local decodeCharacter = function(Hex)
   return string.char(tonumber(Hex, 16))
end

local decodeString = function(String)
   local Output, Index = string.gsub(String, "%%(%x%x)", decodeCharacter)
   return Output
end 

-- [[ SERVICES ]] --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- [[ LOCAL VARIABLES ]]--

local Rarities = {
  [1] = "Common",
  [2] = "Uncommon",
  [3] = "Rare",
  [4] = "Epic",
  [5] = "Legendary"
}

local HopDebounce = false
local Profiles = ReplicatedStorage:WaitForChild(decodeString("%50%72%6F%66%69%6C%65%73"))
local Systems = ReplicatedStorage:WaitForChild(decodeString("%53%79%73%74%65%6D%73"))
local Drops = ReplicatedStorage:WaitForChild(decodeString("%44%72%6F%70%73"))

local Purchase = Systems:WaitForChild(decodeString("%53%68%6F%70%73")):WaitForChild(decodeString("%42%75%79"))
local ItemList = require(Systems:WaitForChild(decodeString("%49%74%65%6D%73")))
local Success, Error = pcall(function(...)
    ItemList = ItemList.GetItemList()
end)

-- just incase module fails to load or an error occurs!
if (not Success or ItemList == nil) then
   return false, "Module Loading Error"
end

-- [[ LOCAL FUNCTIONS ]] --

local RarityTranslation = function(Numeric)
   if Numeric == nil then Numeric = 1 end
   return Rarities[Numeric]
end

local GetItemDisplay = function(Item)
   for index, item_data in pairs(ItemList) do
      if index:lower() == tostring(Item):lower() then
         return item_data.DisplayName or tostring(Item)
      end
      if item_data.DisplayName:lower() == tostring(Item):lower() then
         return item_data.DisplayName or tostring(Item)
      end
   end
   return Item
end

local GetItemRarity = function(Item)
   for index, item_data in pairs(ItemList) do
      if index:lower() == tostring(Item):lower() then
         return RarityTranslation(item_data.Rarity) or "Common"
      end
      if item_data.DisplayName:lower() == tostring(Item):lower() then
         return RarityTranslation(item_data.Rarity) or "Common"
      end
   end
   return "Common"
end

local GetItemLevel = function(Item)
   for index, item_data in pairs(ItemList) do
      if index:lower() == tostring(Item):lower() then
         return item_data.Level or 1
      end
      if item_data.DisplayName:lower() == tostring(Item):lower() then
         return item_data.Level or 1
      end
   end
   return 1
end

local DoesItemExist = function(Item)
   for index, item_data in pairs(ItemList) do
      if index:lower() == tostring(Item):lower() then
         return true, index
      end
      if item_data.DisplayName:lower() == tostring(Item):lower() then
         return true, index
      end
   end
   return false, Item
end

local RandomPlayer = function()
   local Selectable = {}
   local Client = Players.LocalPlayer
   for i, v in pairs(game.Players:GetPlayers()) do
      if v ~= Client then
         table.insert(Selectable, v)
      end
   end
   if #Selectable ~= 0 then
      return Selectable[math.random(1, #Selectable)]
   else
      return false
   end
end

-- [[ MODULE FUNCTIONS ]]--

MainModule.ReturnItemData = function(Item)
   local Price = Item:GetAttribute("Price")
   local Owner = Item:GetAttribute("Owner")
   local Rarity = GetItemRarity(Item)
   local Level = GetItemLevel(Item)
   local Mount = false
   local Speed = nil
   local Enchant = nil
   local UpgradeAmount = nil
   if Item:FindFirstChild("Speed") then
      Mount = true
      Speed = (30 + Item.Speed.Value)
   end
   if Item:FindFirstChild("Enchant") then
      Enchant = Item.Enchant.Value
   end
   if Item:FindFirstChild("Upgrade") then
      UpgradeAmount = Item.Upgrade.Value
   end
   return {
    ["DisplayName"] = GetItemDisplay(Item),
    ["Name"] = tostring(Item),
    ["Price"] = Price,
    ["Owner"] = Owner,
    ["IsMount"] = Mount,
    ["Speed"] = Speed,
    ["Enchant"] = Enchant,
    ["Upgrade"] = UpgradeAmount,
    ["Rarity"] = Rarity,
    ["Level"] = Level
   }
end

MainModule.PurchaseItem = function(Item)
   Purchase:FireServer(Item)
end

MainModule.ValidatePurchase = function(ItemData)
   local Mount = ItemData.IsMount
   local Rarity = ItemData.Rarity
   local Price = ItemData.Price 
   local Level = ItemData.Level
   local Item = ItemData.Name
   local ValidPurchase = true

   if (Price == 0) then
      ValidPurchase = false
      return ValidPurchase, "Invalid Price (0)"
   end
   
   if PurchaseTable["GlobalSettings"] ~= nil and PurchaseTable[tostring(Item)] == nil then
      local Global = PurchaseTable["GlobalSettings"]
      if Global["Price"] ~= nil then
         if Price > Global["Price"] then
            ValidPurchase = false
         end
      end
      if Global["Level"] ~= nil then
         if Global["Level"] > Level then
            ValidPurchase = false
         end
      end
      if Global["Rarity"] ~= nil then
         local RequiredRarity = true
         if Global["RequireRarityForMount"] ~= nil then
            RequiredRarity = Global["RequireRarityForMount"] or true
         end
         if type(Global["Rarity"]) == "table" and RequiredRarity then
            if not table.find(Global["Rarity"], Rarity) then
               ValidPurchase = false
            end
         elseif Global["Rarity"] ~= Rarity and RequiredRarity then
            ValidPurchase = false
         end
      end
      if Mount then
         if Global["Speed"] ~= nil then
            if Global["Speed"] > ItemData.Speed then
               ValidPurchase = false
            end
         end
      end
      return ValidPurchase, "Global"
   end
   
   if PurchaseTable[tostring(Item)] then      
      local PurchaseRequirements = PurchaseTable[tostring(Item)]
      if PurchaseRequirements["Price"] ~= nil then
         if Price > PurchaseRequirements["Price"] then
            ValidPurchase = false
         end
      end
      if Mount then
         if PurchaseRequirements["Speed"] ~= nil then
            if PurchaseRequirements["Speed"] > ItemData.Speed then
               ValidPurchase = false
            end
         end
      end
      return ValidPurchase, "Specific"      
   end
   
   return false, "Nothing Returned, Does this item even exist?"
end

MainModule.ServerHop = function(Mode)
   if HopDebounce then return end
   HopDebounce = true
   if Mode == nil then 
      Mode = "API" 
   end
   if Mode == "API" then
      local random_player = RandomPlayer()
      if random_player ~= false then
         warn("Blocking", (tostring(random_player) .. "..."))
         local domain = "https://accountsettings.roblox.com"
         local method = "/block"
         local path = "/v1/users/"
         local args = random_player.UserId
         local url = (tostring(domain) .. tostring(path) .. tostring(args) .. tostring(method))
         syn.request({
           Url = url,
           Method = "POST"
         })
      end
      wait(2)
      while true do 
         TeleportService:Teleport(game.PlaceId) 
         wait() 
      end
   elseif Mode == "RAM" then
      local random_player = RandomPlayer()
      if random_player ~= false then
         warn("Blocking", (tostring(random_player) .. "..."))
         local localhost = "http://localhost:"
         local method = "BlockUser"
         local port = 7963
         local args = "?Account=" .. tostring(Players.LocalPlayer.Name) .. "&UserId=" .. tostring(random_player.UserId)
         local url = (localhost .. tostring(port) .. "/" .. tostring(method) .. tostring(args))
         syn.request({
           Url = url,
           Method = "GET"
         })
      end
      wait(2)
      while true do 
         TeleportService:Teleport(game.PlaceId) 
         wait() 
      end
   end
end

MainModule.AddItem = function(Item, Requirements)
   local DoesExist, ActualName = DoesItemExist(tostring(Item))
   if DoesExist then
      PurchaseTable[tostring(ActualName)] = Requirements
      warn("Item Added To Purchase Table:", tostring(ActualName))
      return true, "Success"
   end
   return false, "Item Does Not Exist"
end

MainModule.UpdateGlobalSettings = function(Requirements)
   PurchaseTable["GlobalSettings"] = Requirements
   return true, "Updated Global Settings"
end

MainModule.AddTag = function(Item, Tag)
   local Folder = Instance.new("Folder")
   Folder.Name = Tag
   Folder.Parent = Item
   return true, "Success Added Tag", Folder
end

MainModule.CheckTag = function(Item, Tag)
   if Item:FindFirstChild(Tag) then
      return true, "Found Tag"
   end
   return false, "Not Tagged"
end

MainModule.ClearTags = function(Tag)
   local Success, Error = pcall(function(...)
       for index, profile in pairs(Profiles:GetChildren()) do
          if profile:FindFirstChild("Inventory") then
             for indexA, item in pairs(profile.Inventory:GetChildren()) do
                if item:FindFirstChild(Tag) then
                   item[Tag]:Destroy()
                end
             end
          end
       end
   end)
   if not Success then
      return Success, ("Error - " .. tostring(Error))
   end
   return Success, "Success Cleared Tags"
end

MainModule.CreateTimer = function(Time, Function)
   local Timer = 0
   local Thread = coroutine.create(function(...)
       while true do
          wait(1)
          Timer = Timer + 1
          if Timer >= Time then
             break;
          end
       end
       Function()
   end)
   local ResetTimer = function()
      Timer = 0
      return Timer
   end
   coroutine.resume(Thread)
   warn("Timer Will Trigger Function in", tostring(Time / 60), "Minute(s)")
   return ResetTimer, Thread
end

MainModule.BlockedUserCount = function(...)
   local Request = syn.request({
     Url = "https://accountsettings.roblox.com/v1/users/get-detailed-blocked-users",
     Method = "GET"
   }); local Data;
   local Success, Error = pcall(function(...)
       Data = HttpService:JSONDecode(Request.Body)
   end)
   if Success then
      return Success, Data.total
   end
   return Success, ("Error - " .. tostring(Error))
end

MainModule.UnblockAllUsers = function(...)
   local Request = syn.request({
     Url = "https://accountsettings.roblox.com/v1/users/get-detailed-blocked-users",
     Method = "GET"
   }); local Data;
   local Success, Error = pcall(function(...)
       Data = HttpService:JSONDecode(Request.Body)
   end)
   if Success then
      local BlockedUsers = Data.blockedUsers
      for index, player in pairs(BlockedUsers) do
         local domain = "https://accountsettings.roblox.com"
         local method = "/unblock"
         local path = "/v1/users/"
         local args = tostring(player.userId)
         local url = tostring(domain .. path .. args .. method)
         local request = syn.request({
           Url = url,
           Method = "POST"
         })
         local unblock_data;
         local unblock_success, unblock_error = pcall(function(...)
             unblock_data = HttpService:JSONDecode(request.Body)
         end)
         if unblock_success then
            if unblock_data.errors ~= nil then
               warn("There was an error unblocking:", player.name)
            else
               warn("Succesfully unblocked:", player.name)
            end
         end
         wait(.25)
      end 
      return Success, "Complete"
   end
   return Success, ("Error - " .. tostring(Error))
end
      
MainModule.ReturnCurrentDrops = function(...)
   return Drops:GetChildren()
end

MainModule.ReturnPurchaseTable = function(...)
   return PurchaseTable
end

MainModule.AntiAfk = function(...)
    local Client = Players.LocalPlayer
    Client.Idled:Connect(function(...)
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    return true, "Success Loaded Anti-AFK"
end

-- [[ INIT ]]--

return true, MainModule
