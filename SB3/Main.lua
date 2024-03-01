-- [[ CORE ]]--

local MainModule = {Version = 1}

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

-- [[ MODULE FUNCTIONS ]]--

MainModule.ReturnItemData = function(Item)
   local Price = Item:GetAttribute("Price")
   local Owner = Item:GetAttribute("Owner")
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
    ["Upgrade"] = UpgradeAmount
   }
end

-- [[ INIT ]]--

return true, MainModule
