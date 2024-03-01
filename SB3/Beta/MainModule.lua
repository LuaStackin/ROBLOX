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
      if index == tostring(Item) or item_data.DisplayName == tostring(Item) then
         return item_data.DisplayName or tostring(Item)
      end
   end
   return Item
end

local GetItemRarity = function(Item)
   for index, item_data in pairs(ItemList) do
      if index == tostring(Item) or item_data.DisplayName == tostring(Item) then
         return RarityTranslation(item_data.Rarity) or "Common"
      end
   end
   return "Common"
end

local GetItemLevel = function(Item)
   for index, item_data in pairs(ItemList) do
      if index == tostring(Item) or item_data.DisplayName == tostring(Item) then
         return item_data.Level or 1
      end
   end
   return 1
end

local DoesItemExist = function(Item)
   for index, item_data in pairs(ItemList) do
      if index == tostring(Item) or item_data.DisplayName == tostring(Item) then
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
         if type(Global["Rarity"]) == "table" then
            if not table.find(Global["Rarity"], Rarity) then
               ValidPurchase = false
            end
         elseif Global["Rarity"] ~= Rarity then
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
   if Mode == nil then 
      Mode = "API" 
   end
   if Mode == "API" then
      local random_player = RandomPlayer()
      if random_player ~= false then
         warn("Blocking", (tostring(random_player) .. "..."))
         domain = "https://accountsettings.roblox.com"
         method = "/block"
         path = "/v1/users/"
         args = random_player.UserId
         url = (tostring(domain) .. tostring(path) .. tostring(args) .. tostring(method))
         syn.request({
           Url = url,
           Method = "POST"
         })
      end
      wait(2)
      TeleportService:Teleport(game.PlaceId)
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
      TeleportService:Teleport(game.PlaceId)
   end
end

MainModule.AddItem = function(Item, Requirements)
   local DoesExist, ActualName = DoesItemExist(tostring(Item))
   if DoesExist then
      PurchaseTable[tostring(ActualName)] = Requirements
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

MainModule.ReturnCurrentDrops = function(...)
   return Drops:GetChildren()
end

MainModule.ReturnPurchaseTable = function(...)
   return PurchaseTable
end

-- [[ INIT ]]--

return true, MainModule
