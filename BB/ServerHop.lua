local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place,_id = game.PlaceId, game.JobId

if _G.Settings == nil then
   Mode = _G.Mode
else
   Mode = _G.Settings["SearchMode"]
end

local _servers = Api.._place.."/servers/Public?sortOrder=" .. tostring(Mode) .. "&limit=100"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end
time_to_wait = 0 --seconds
local ValidServers = {}
local Servers = ListServers()
local Server = Servers.data[math.random(1,#Servers.data)]
local PreviousServerData = {}
local SuccessRet, Error = pcall(function(...)
    PreviousServerData = game:GetService("HttpService"):JSONDecode(readfile("Previous.json"))
end)
if not SuccessRet then
   local SuccessWri, Error = pcall(function(...)
       writefile("Previous.json", game:GetService("HttpService"):JSONEncode({game.JobId}))
   end)
else
   table.insert(PreviousServerData, tostring(game.JobId))
   writefile("Previous.json", game:GetService("HttpService"):JSONEncode(PreviousServerData))
   warn("Updated Previous Data:", tostring(game:GetService("HttpService"):JSONEncode(PreviousServerData)))
end                                                                                                                                                                                
for i, v in pairs(Servers.data) do
   if table.find(PreviousServerData, tostring(v.id)) then
      warn("Removed Index", tostring(i), "[", tostring(v.id), "]", "As it was a previous server.")
      table.remove(Servers, i) 
   else
      table.insert(ValidServers, v)
   end
   if tostring(v.id) == game.JobId then
      warn("Removed Index", tostring(i), "[", tostring(v.id), "]", "Because it is the current server.")
      table.remove(Servers, i)
   end
end
warn("V1.1 - COMPLETED.")
while true do
   for i = 1, #ValidServers do
      warn("Attempting to teleport to", tostring(ValidServers[i].id))
      local Server = ValidServers[i]
      TPS:TeleportToPlaceInstance(_place, Server.id, Player)
      wait()
   end
   wait()
end
