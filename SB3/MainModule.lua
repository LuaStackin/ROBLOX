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
      if index == tostring(Item) then
         return item_data.DisplayName or tostring(Item)
      end
   end
   return Item
end

local GetItemRarity = function(Item)
   for index, item_data in pairs(ItemList) do
      if index == tostring(Item) then
         return RarityTranslation(item_data.Rarity) or "Common"
      end
   end
   return "Common"
end

local DoesItemExist = function(Item)
   for index, item_data in pairs(ItemList) do
      if index == tostring(Item) or item_data.DisplayName == tostring(Item) then
         return true, index
      end
   end
   return false, Item
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
      local Mount = ItemData.IsMount
      local Rarity = ItemData.Rarity
      local Price = ItemData.Price
      
      local PurchaseRequirements = PurchaseTable[tostring(Item)]
      if PurchaseRequirements["Price"] ~= nil then
         if Price > PurchaseRequirements["Price"] then
            ValidPurchase = false
         end
      end
      if PurchaseRequirements["Level"] ~= nil then
         if PurchaseRequirements["Level"] > Level then
            ValidPurchase = false
         end
      end
      if PurchaseRequirements["Rarity"] ~= nil then
         if type(PurchaseRequirements["Rarity"]) == "table" then
            if not table.find(PurchaseRequirements["Rarity"], Rarity) then
               ValidPurchase = false
            end
         elseif PurchaseRequirements["Rarity"] ~= Rarity then
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
   
   return false, "Nothing Returned"
end

MainModule.AddItem = function(Item, Requirements)
   if DoesItemExist(tostring(Item)) then
      PurchaseTable[tostring(Item)] = Requirements
      return true, "Success"
   end
   return false, "Item Does Not Exist"
end

MainModule.UpdateGlobalSettings = function(Requirements)
   PurchaseTable["GlobalSettings"] = Requirements
   return true, "Updated Global Settings"
end

MainModule.ReturnCurrentDrops = function(...)
   return Drops:GetChildren()
end

MainModule.ReturnPurchaseTable = function(...)
   return PurchaseTable
end

-- [[ INIT ]]--

return true, MainModule
