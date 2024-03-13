wait(3) -- loading delay

-- services 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- variables

local Client = Players.LocalPlayer

-- locations

local Mobs = workspace.Mobs
local Drops = ReplicatedStorage.Drops
local Effects = ReplicatedStorage.Systems.Effects
local WEffects = workspace.Effects
local MobSpawns = workspace.MobSpawns

-- Settings

local Mob = "Hell Hound" -- (Hell Hound, Cold Mammoth)
local HitDelay = 0.2 -- seconds
local MinDistance = 30 -- studs
local PositionDistance = 24
local BreakLoop = false

if getgenv().Settings ~= nil then
   local Settings = getgenv().Settings
   if Settings.Mob ~= nil then
      Mob = Settings.Mob  
      warn("Set Mob:", Mob)
   end
   if Settings.AttackDelay ~= nil then
      HitDelay = Settings.AttackDelay
      warn("Set Hit Delay:", HitDelay)
   end
   if Settings.PositionDistance ~= nil then
      MinDistance = Settings.PositionDistance + 15
      PositionDistance = Settings.PositionDistance
      warn("Set Distance:", PositionDistance)
      warn("Set Mininum Distance:", MinDistance)
   end
end

warn("init 1")

-- Remotes & Other

local Part = Instance.new("Part"); Part.Anchored = true; Part.Size = Vector3.new(25, 3, 25); Part.Parent = workspace;
local CombatRemote = ReplicatedStorage.Systems.Combat.PlayerAttack
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

if getgenv().CMHFUNC then
   getgenv().CMHFUNC()
end

if getgenv().AAFK then
   warn("Disconnected Anti-AFK")
   getgenv().AAFK:Disconnect()
end

if getgenv().DEffects then
   warn("Disconnected Delete Effects")
   getgenv().DEffects:Disconnect()   
end

warn("init 3")

getgenv().CTPFUNC = RenderStepped:Connect(function(...)
    if Client.Character then
       local Character = Client.Character
       if Character:FindFirstChild("HumanoidRootPart") and Mobs:FindFirstChild(Mob) then
          local HRP = Character.HumanoidRootPart
          local Mob = Mobs[Mob] 
          if Mob:GetAttribute("HP") <= 0  then
             Mob:Destroy()
             return
          end
          HRP.CFrame = Mob.HumanoidRootPart.CFrame * CFrame.new(0, -PositionDistance, 0)
          Part.CFrame = HRP.CFrame * CFrame.new(0, -4, 0)
       elseif Character:FindFirstChild("HumanoidRootPart") and not Mobs:FindFirstChild(Mob) then
          local SPW = MobSpawns[Mob]
          local HRP = Character.HumanoidRootPart
          HRP.CFrame = SPW.CFrame * CFrame.new(0, -15, 0)
          Part.CFrame = HRP.CFrame * CFrame.new(0, -4, 0)          
       end
       for i, v in pairs(Drops:GetChildren()) do
          PickupRemote:FireServer(v)
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

getgenv().CMHFUNC = function(...)
   BreakLoop = true
end

getgenv().AAFK = Idled:Connect(function(...)
     VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
     wait(1)
     VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)    
end) 

getgenv().DEffects = WEffects.ChildAdded:Connect(function(Effect)
    wait(.1)
    Effect:Destroy()
end)

warn("init 4")

if not getgenv().OriginalEffects then
   getgenv().OriginalEffects = Effects:Clone()
end

for i, v in pairs(Effects:GetChildren()) do
   v:Destroy()
end

warn("init 5 - complete")

while true do
   if BreakLoop then 
      warn("Exiting While Loop!")
      Part:Destroy()
      break;
   end
   local Success, Error = pcall(function(...)
       if Mobs:FindFirstChild(Mob) then
          local Mob = Mobs:FindFirstChild(Mob)

          local Mob_Root = nil
          local Player_Root = nil

          if Mob:FindFirstChild("HumanoidRootPart") then
             Mob_Root = Mob:FindFirstChild("HumanoidRootPart")
          end

          if Client.Character then
             local Character = Client.Character
             if Character:FindFirstChild("HumanoidRootPart") then
                Player_Root = Character:FindFirstChild("HumanoidRootPart")
             end
          end

          if (Mob_Root ~= nil and Player_Root ~= nil) then
             local Distance = (Player_Root.Position - Mob_Root.Position).magnitude
             if MinDistance >= Distance then
                wait(HitDelay)
                CombatRemote:FireServer({[1] = Mob})
                warn("Attacked Mob!")
             end
          end
       end
   end)
   if not Success then
      warn(Error)
   end
   wait()
end
