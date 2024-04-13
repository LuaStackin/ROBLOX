local MainModule = {}
local HopDebounce = false

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

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
return MainModule
