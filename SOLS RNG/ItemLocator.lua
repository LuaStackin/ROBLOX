-- [[ #MAIN_MODULE ]]--

local Source = "https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/SOLS%20RNG/MainModule.lua"
local HttpSuccess, HttpReturn = pcall(game.HttpGet, game, Source)

-- [[ #SERVICES_REQUIRED ]]--

local Players = game:GetService("Players")

-- [[ #MODULE_LOADING ]]--

local MainModule, Success = loadstring(HttpReturn)()

-- [[ #MODULE_FUNCTIONS ]]--

local Pathfind, AntiAFK = MainModule.SimplePathFind, MainModule.AntiAFK

-- [[ #LOCAL_VARIABLES ]]--

local DroppedFolder = workspace:WaitForChild("DroppedItems")
local Client = Players.LocalPlayer

-- [[ #LOCAL_FUNCTIONS ]]--

local ScanDrops = function(...)
    for i, v in pairs(DroppedFolder:GetChildren()) do
        local Descendants = v:GetDescendants()
        for index, value in pairs(Descendants) do
            if value:IsA("ProximityPrompt") then
                if game.Players.LocalPlayer.Character then
                    local Character = game.Players.LocalPlayer.Character
                    if Character:FindFirstChild("HumanoidRootPart") then
                        local Root = Character.HumanoidRootPart
                        local Humanoid = Character.Humanoid
                        local TargetPart = value.Parent
                        if not value:FindFirstChild("W") then
                            Instance.new("BoolValue", value).Name = "W"
                            warn("Item.-", TargetPart.Name, TargetPart.Parent.Name)
                            print("==============================")
                        end
                        local Success, Error =
                            pcall(
                            function(...)
                                local s,e = MainModule.SimplePathFind(Root, Humanoid, TargetPart); warn(s,e)
                                fireproximityprompt(value, 0)
                            end
                        )
                        if not Success then
                            warn("Error.-", Error)
                        end
                    end
                end
            end
        end
    end
end

-- [[ #MAIN_SCRIPT ]]--

if Client.Character then
   if Client.Character:FindFirstChild("Humanoid") then
      Client.Character.Humanoid.WalkSpeed = 30 -- just to make you a little faster :D
   end
end 
MainModule.AntiAFK(); warn("Loaded - Success")
while true do
   local Function_Success, Function_Error = pcall(ScanDrops)
   if not Function_Success then
      warn("UNKNOWN-ERROR.-", Function_Error)
   end
   wait()
end
