-- loading

if not game:IsLoaded() then game.Loaded:Wait() end
if game.GameId ~= 1016936714 then return end

-- settings

local Items = getgenv().Settings["Items"]
local Secure = getgenv().Settings["Secure1"]
local Secure2 = getgenv().Settings["Secure2"]

-- services 

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- variables

local Client = Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")
local LoadingScreen = PlayerGui:WaitForChild("LoadingScreen", 5)

-- functions

local function click(button, manual)
    for i, v in pairs(getconnections(button.MouseButton1Click)) do
        if manual then
            v.Function()
        else
            v:Fire()
        end
    end
    print("Clicked", button)
end

-- tpbypass

local TPBypass
TPBypass = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...)
     local args = {...}
     if self.Name == "Returner" and args[1] == "idklolbrah2de"  then
         return "  ___XP DE KEY"
     end
     return TPBypass(self, ...)
end))

-- main

Secure.OnClientInvoke = Secure2
if LoadingScreen ~= nil then
   local Play = LS:WaitForChild("Frames"):WaitForChild("Main"):WaitForChild("Play")
   click(Play, false)
end
