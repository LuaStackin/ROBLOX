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
      description = string.format("SERVER ID: %s", tostring(game.JobId)),
      color = 8192223,
      fields = {}
   }}}
end

local _CreateField_ = function(Name, Rap, Price, Percentage, Rarity)
   return {
    name = Name,
    value = string.format("RAP: **%s**\nPrice: **%s**\nPercentage: **%s%%**\nRarity: **%s**", tostring(Rap), tostring(Price), tostring(Percentage), tostring(Rarity)),
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
         if Listing["Rarity"]:lower() == "limited" or Listing["Rarity"]:lower() == "unique" then
            if Listing["Price"] >= 5000 then
               local Success, Rap, Finisher = Listing["RequestItemRAP"]()
               if Success then
                  if Rap > Listing["Price"] then
                     Listing["Name"] = Listing["Name"] .. " [UNDER RAP]"
                  end
                  
                  Percentage = (Listing["Price"] / Rap) * 100
                  Percentage = string.format("%.0f", Percentage)
   
                  local Field = _CreateField_(Listing["Name"], Rap, Listing["Price"], Percentage, Listing["Rarity"])
                  table.insert(Fields, Field)
               end
            end
         end
      end
      if #Fields ~= 0 then
         local Embed = _CreateEmbed_(OwnerOfListings)
         for _, EmbedField in pairs(Fields) do
            table.insert(Embed.embeds[1].fields, EmbedField)
         end
         SendHook(1, Embed) 
      end
   end
end

local _SetHook_ = function(Index, Value)
   Hooks[Index] = tostring(Value)
end

local _ServerHop_ = function()
   return loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/BB/ServerHop.lua"))()
end

-- Hi, this is just testing not really useful.
return _Main_, _SetHook_, _ServerHop_
