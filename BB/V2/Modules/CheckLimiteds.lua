--// Loading
repeat wait() until game.IsLoaded

--// Loading Functions (V2)
local Success, ListingHandler, RapFunction, ScriptVersion = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/BB/V2/Main.lua")
if not Success then
   warn(string.format("Something went wrong while loading the listening handler: %s", tostring(ListingHandler)))
else
   ListingHandler, RapFunction, ScriptVersion = loadstring(ListingHandler)()
end

local Hooks = {}

--// Custom Functions
local SendHook = function(Index, Data)
   return syn.request({
     Url = Hooks[Index],
     Method = "POST",
     Headers = {["Content-Type"] = "application/json"},
     Body = game:GetService("HttpService"):JSONEncode(Data)
   })
end

local _CreateEmbed_ = function(Name)
   return {content = nil, embeds = {{
      title = string.format("LIMITED BOOTH CHECKER (%s)", tostring(Name)),
      color = 8192223,
      fields = {}
   }}}
end

local _CreateField_ = function(Name, Rap, Price, Percentage)
   return {
    name = Name,
    value = string.format("RAP: **%s**\nPrice: **%s**\nPercentage: **%s%%**", tostring(Rap), tostring(Price), tostring(Percentage)),
    inline = true
   }
end

--// Main Script
local _Main_ = function()
   local Listings = ListingHandler()
   for _, PlayerListing in pairs(Listings) do
      local OwnerOfListings = nil
      local Fields = {}
      for _, Listing in pairs(PlayerListing) do
         OwnerOfListings = tostring(Listing["Owner"])
         if Listing["Rarity"]:lower() == "limited" then
            if Listing["Price"] >= 5000 then
               local Success, Rap, Finisher = Listing["RequestItemRAP"]()
               if Success then
                  local Field = _CreateField_(Listing["Name"], Rap, Listing["Price"], "Not Added YET.")
                  table.insert(Fields, Field)
               end
            end
         end
      end
      local Embed = _CreateEmbed_(OwnerOfListings)
      for _, EmbedField in pairs(Fields) do
         table.insert(Embed.embeds[1].fields, EmbedField)
      end
   end
end

local _SetHook_ = function(Index, Value)
   Hooks[Index] = tostring(Value)
end

-- Hi, this is just testing not really useful.
return _Main_, _SetHook_
