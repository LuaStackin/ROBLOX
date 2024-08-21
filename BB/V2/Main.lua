local Version = 1

--// Loading, Services & Yield(s)

repeat wait() until game.IsLoaded

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ControllersFolder = ReplicatedStorage:WaitForChild("Controllers", 5)
local PackagesFolder = ReplicatedStorage:WaitForChild("Packages", 5)
local SharedFolder = ReplicatedStorage:WaitForChild("Shared", 5)

if (ControllersFolder == nil or PackagesFolder == nil or SharedFolder == nil or game.PlaceId ~= 16581637217) then 
   game:GetService("TeleportService"):Teleport(16581637217)
   return;
end

--// Booth Controller
local BoothController = require(ControllersFolder:WaitForChild("Booth"):WaitForChild("BoothController"))
local Listings = BoothController.BoothListings.Data

--// Item Data
local ItemInfo = require(SharedFolder:WaitForChild("ItemInfo"))
local RapCache = {}
local RapCacheFunction = function(Method, Name, Finisher, Value) 
   local RapType = "Finisher" and Finisher == true or "Regular"
   if Method == "SUBMIT" then
      if RapCache[Name] ~= nil then
         RapCache[Name][RapType] = Value 
         return true, "SET CACHE."
     else
         RapCache[Name] = {Finisher = nil, Regular = nil}
         RapCache[Name][RapType] = Value
         return true, "SET CACHE."
      end
      return false, "COULD NOT SET CACHE?"
   elseif Method == "GET" then
      if RapCache[Name] ~= nil then
         if RapCache[Name][RapType] ~= nil then
            return true, RapCache[Name][RapType]
         else
            return false, "TYPE NOT CACHED."
         end
      else
         return false, "NOT CACHED."
      end
      return false, "COULD NOT FETCH CACHE DATA."
   else
      return false, "INVALID METHOD."
   end
end

--// Rap Function
local RequestRap = PackagesFolder:WaitForChild("_Index"):WaitForChild("sleitnick_net@0.1.0"):WaitForChild("net"):WaitForChild("RF/RequestItemRAP")
local RapFunction = function(Type, Name, Finisher)
   local RapData;
   if Finisher == true then
      RapData = string.format('[["Finisher",true],["Name","%s"]]', tostring(Name))
   elseif Finisher == false or Finisher == nil then
      RapData = string.format('[["Name","%s"]]', tostring(Name))
   end
   local Success, CacheData = RapCacheFunction("GET", tostring(Name), Finisher) 
   if Success then
      return Success, CacheData, Finisher
   end
   local Success, RAP = RequestRap:InvokeServer(Type, RapData, os.time())
   if Success then 
      local Success, CacheData = RapCacheFunction("SUBMIT", tostring(Name), Finisher, RAP)
      if Success then
         warn(Success, CacheData, tostring(Name))
      end
   end
   return Success, RAP, Finisher
end

--// Custom Functions
local MatchPlayer = function(UserId)
   for i, v in pairs(game:GetService("Players"):GetPlayers()) do 
      if tostring(v.UserId) == UserId then
         return true, v
      end
   end
   return false, nil
end

local CheckName = function(Type, Name)
   if Type == "Emote" then
      for ItemIndex, ItemData in pairs(ItemInfo.ItemInfos) do
         if ItemData.Name == Name then
            return ItemData.DisplayName
         end
      end
   end
   return Name
end

local CheckRarity = function(Name)
   for ItemIndex, ItemData in pairs(ItemInfo.ItemInfos) do
       if ItemData.Name == Name then
          return ItemData.Rarity or "Unknown"
       end
   end
   return "Developer Exclusive"
end

local FormatListings = function(...)
   local FListings = {}
   for i, v in pairs(Listings) do
      local Success, PlayerInstance = MatchPlayer(i)
      if Success then
         FListings[tostring(i)] = {}
         for ListingId, ListingData in pairs(v) do             
            local CustomData = {
             ["Finisher"] = (ListingData.Item.Finisher == true or false),
             ["RequestItemRAP"] = function(...)
                return RapFunction(ListingData.Type, ListingData.ItemName, (ListingData.Item.Finisher == true or false))
             end,
             ["Price"] = ListingData.Price,
             ["Name"] = CheckName(ListingData.Type, ListingData.ItemName),
             ["Rarity"] = CheckRarity(ListingData.ItemName),
             ["Owner"] = PlayerInstance or tostring(i)
            } 
            table.insert(FListings[tostring(i)], CustomData)
         end
      end
   end
   return FListings
end

--// Return, keeping this private :D FUCK OFF!!!!!!! Code the rest yourself.
return FormatListings, Version
