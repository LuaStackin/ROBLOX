wait(3) -- loading delay

-- services 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- variables

local Client = Players.LocalPlayer

-- locations

local Ores = workspace.Ores
local Drops = ReplicatedStorage.Drops
local Effects = ReplicatedStorage.Systems.Effects

-- Settings

local Ore = "Quartz"

if getgenv().Settings ~= nil then
   local Settings = getgenv().Settings
   if Settings.Ore ~= nil then
      Ore = Settings.Ore
   end
end

warn("init 1")

-- Remotes & Other

local Part = Instance.new("Part"); Part.Anchored = true; Part.Size = Vector3.new(25, 3, 25); Part.Parent = workspace;
local MineRemote = ReplicatedStorage.Systems.Mining.Mine
local PickupRemote = ReplicatedStorage.Systems.Drops.Pickup

-- Connections

local RenderStepped = RunService.RenderStepped
local Stepped = RunService.Stepped
local Idled = Client.Idled

warn("init 2")

if getgenv().CTPFUNC then
   warn("Disconnected Teleport")
   getgenv().CTPFUNC:Disconnect()
end

if getgenv().CNCFUNC then
   warn("Disconnected Noclip")
   getgenv().CNCFUNC:Disconnect()
end

if getgenv().AAFK then
   warn("Anti-AFK, Disconnected!")
   getgenv().AAFK:Disconnect()
end

if getgenv().CMOFUNC then
   getgenv().CMOFUNC()
end 

getgenv().CTPFUNC = Stepped:Connect(function(...)
    if Client.Character then
       local Character = Client.Character
       if Character:FindFirstChild("HumanoidRootPart") and Ores:FindFirstChild(Ore) then
          local HRP = Character.HumanoidRootPart
          local ORP = Ores[Ore].Quartz
          HRP.CFrame = ORP.CFrame * CFrame.new(0, -8, 0)
          Part.CFrame = HRP.CFrame * CFrame.new(0, -5, 0)
       end
    end  
end)

getgenv().CNCFUNC = Stepped:Connect(function(...)
    for i, v in pairs(Client.Character:GetChildren()) do
       if v:IsA("BasePart") then
          v.CanCollide = false
       end
    end
end)

getgenv().CMOFUNC = function(...)
   BreakLoop = true
end

warn(getgenv().AAFK)

getgenv().AAFK = Idled:Connect(function(...)
     VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
     wait(1)
     VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)    
end) 

warn("init 4 - complete")

while true do
   if BreakLoop then 
      warn("Exiting While Loop!")
      Part:Destroy()
      break;
   end
   local Success, Error = pcall(function(...)
	MineRemote:FireServer()
        for i, v in pairs(Drops:GetChildren()) do
           PickupRemote:FireServer(v)
        end
   end)
   if not Success then
      warn(Error)
   end
   wait(.8)
end
