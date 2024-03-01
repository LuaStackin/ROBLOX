-- [[ #MODULE_BODY ]]--

local Source = "https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/SB3/InitModule.lua"
local HttpSuccess, HttpReturn = pcall(game.HttpGet, game, Source)

-- [[ #MODULE_LOADING ]]--

local InitModule, UpdateGlobal, AddItem = loadstring(HttpReturn)()

-- [[ #SETUP_FUNCTION ]]--

local KillSwitch = InitModule.Setup("RunService", function(Item_Data)
    warn("Purchased -", Item_Data.DisplayName)
end)

--[[ EXAMPLE USAGE:
local KillSwitch = InitModule.Setup("RunService", function(Item_Data)
    warn("Purchased -", Item_Data.DisplayName)
end)

KillSwitch:Disconnect() / KillSwitch() depending on which loop you choose, will terminate the loop.
Item_Data Returns: Table: -- > {Name, DisplayName, Price, Owner, Upgrade, Enchant, IsMount, Speed, Rarity, Level}

UpdateGlobal({
  ["Price"] = 10, -- Max Price to Purchase
  ["Level"] = 1, -- Mininum Level to Purchase
  ["Rarity"] = {"Legendary"}, -- Required Rarity/Rarities to Purchase
  ["Speed"] = 1, -- Required Mount Speed (IF MOUNT!)
  ["RequireRarityForMount"] = false -- use rarity for mounts? (true/false)
})

AddItem("ItemName", {
  ["Price"] = 1, -- Max Purchase Price,
  ["Speed"] = 30 -- Mininum Mount Speed (only works for mounts, obviously)
})
--]]

--[[ REAL USAGE:
UpdateGlobal({
  ["Price"] = 1000, -- Max Price to Purchase
  ["Level"] = 45, -- Mininum Level to Purchase
  ["Rarity"] = {"Legendary"}, -- Required Rarity/Rarities to Purchase
  ["Speed"] = 39, -- Required Mount Speed (IF MOUNT!)
  ["RequireRarityForMount"] = false -- use rarity for mounts? (true/false)
})

AddItem("infernalarmor", {["Price"] = 100})
AddItem("pureruby", {["Price"] = 100})
AddItem("phoenix", {["Price"] = 10000, ["Speed"] = 37})
]]--
