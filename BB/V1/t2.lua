--// Loading

repeat wait() until game.IsLoaded

--// Loading Functions

local Success, ListingHandler, ScriptVersion = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/BB/V1/Main.lua")
if not Success then
   warn(string.format("Something went wrong while loading the listening handler: %s", tostring(ListingHandler)))
end

--// Settings

local ItemRapCache = {}
local AutoPurchase = {}
local AddItem = function(Name, Price, NonFinisherPrice, RequireFinisher, LoggingEnabled, RapLoggingEnabled)
   AutoPurchase[tostring(Name):lower()] = {
    ["MaxPrice"] = Price, 
    ["NonFinisherPrice"] = NonFinisherPrice,
    ["RequireFinisher"] = RequireFinisher,
    ["LoggingEnabled"] = LoggingEnabled,
    ["UpdateRAP"] = RapLoggingEnabled
   }
end

--// Items
AddItem("Dual Luminara", 1200, 0, true, true, true)
AddItem("Chimera's Bane", 1200, 0, true, true, true)

AddItem("Dual Eternal Blasters", 2300, 0, true, true, true)
AddItem("Dual Galaxy Nunchucks", 2300, 0, true, true, true)

AddItem("Laser Twinblade", 7000, 900, false, true, true)
AddItem("Dual Chroma Blasters", 9000, 0, true, true, true)
AddItem("Dual Nebula Blasters", 9000, 0, true, true, true)

AddItem("Dual Cyber Sickle", 13000, 0, true, true, true)
AddItem("Triple Devil Katana", 15000, 0, true, true, true)

--// Validation Functions
local ValidatePurchase = function(Name, Price, Finisher, GetRapFunc) do
   local APData = AutoPurchase[tostring(Name):lower()]
   if APData ~= nil then
      local ItemRap = "DISABLED";
      if APData.UpdateRAP == true then
         if ItemRapCache[tostring(Name):lower()] ~= nil then
            if ItemRapCache[tostring(Name):lower()].Finisher == "UNCHECKED" or ItemRapCache[tostring(Name):lower()].Regular == "UNCHECKED" then
               local Success, Rap, Finisher = GetRapFunc()
               if Success then
                  if Finisher then
                     ItemRapCache[tostring(Name):lower()].Finisher = Rap
                  else
                     ItemRapCache[tostring(Name):lower()].Regular = Rap
                  end
               else
                  ItemRap = "FAILED TO LOAD [CACHE]"
               end
            end
            if Finisher and ItemRapCache[tostring(Name):lower()].Finisher ~= "UNCHECKED" then
               ItemRap = ItemRapCache[tostring(Name):lower()].Finisher
            elseif not Finisher and ItemRapCache[tostring(Name):lower()].Regular ~= "UNCHECKED" then
               ItemRap = ItemRapCache[tostring(Name):lower()].Regular
            end
         else
            local Success, Rap, Finisher = GetRapFunc()
            if Success then
               if Finisher then
                  ItemRapCache[tostring(Name):lower()] = {Finisher = Rap, Regular = "UNCHECKED"}
               else
                  ItemRapCache[tostring(Name):lower()] = {Finisher = Rap, Regular = "UNCHECKED"}
               end
               ItemRap = Rap
            else
               ItemRap = "FAILED TO LOAD"
            end
         end
      end
      if Finisher == true then
         if Price >= APData.Price then
            return true, true, ItemRAP
         else
            return true, false, ItemRAP
         end
      elseif (Finisher == false or Finisher == nil) and APData.RequireFinisher == false then
         if Price >= APData.NonFinisherPrice then
            return true, true, ItemRAP
         else
            return true, false, ItemRAP
         end
      end
   end
   return false, false, 0
end

--// Main
print(string.format("Success, loaded version: V%s", ScriptVersion))
