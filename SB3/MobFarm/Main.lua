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

local DisableEffects = true
local BreakLoop = false

if getgenv().KillSwitch then
   getgenv().KillSwitch()
end

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
   if Settings.DisableEffects ~= nil then
      DisableEffects = Settings.DisableEffects
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

local ThreadCreate = coroutine.create
local ThreadRun = coroutine.resume

warn("init 2")

getgenv().SelectMobAndTeleport = function(...)
    if Mobs:FindFirstChild(Mob) then
       SelectedMob = Mobs:FindFirstChild(Mob)
    end
    if SelectedMob ~= nil then
       local Root = nil
       if 0 >= SelectedMob:GetAttribute("HP") then
          SelectedMob:Destroy()
          SelectedMob = nil
          return
       end
       if Client.Character then
          local Character = Client.Character
          if Character:FindFirstChild("HumanoidRootPart") then
             Root = Character:FindFirstChild("HumanoidRootPart")
          end
       end
       if Root ~= nil then
          Root.CFrame = SelectedMob.HumanoidRootPart.CFrame * CFrame.new(0, -PositionDistance, 0)
          Part.CFrame = HRP.CFrame * CFrame.new(0, -4, 0)
          wait()
          CanAttack = true
       end
    end
end

getgenv().DamageMob = function(...)
   if SelectedMob ~= nil then
      local Root = nil
      if Client.Character then
         local Character = Client.Character
         if Character:FindFirstChild("HumanoidRootPart") then
            Root = Character:FindFirstChild("HumanoidRootPart")
         end
      end
      if Root ~= nil then
         local DistanceFromMob = (Root.Position - SelectedMob.HumanoidRootPart.Position).magnitude
         if MinDistance >= DistanceFromMob then
            wait(HitDelay)
            CombatRemote:FireServer({[1] = SelectedMob})
         end
      end
   end
end

local Thread_Function1 = ThreadRun(ThreadCreate(function(...)
     local Function = getgenv().SelectMobAndTeleport
     while true do
        local Success, Error = pcall(Function)
        if not Success then
           warn("Error Running Function:", Function, "// Error:", Error)
        end
        wait()
     end
end))

local Thread_Function2 = ThreadRun(ThreadCreate(function(...)
     local Function = getgenv().DamageMob
     while true do
        local Success, Error = pcall(Function)
        if not Success then
           warn("Error Running Function:", Function, "// Error:", Error)
        end
        wait()
     end
end))

getgenv().Noclip = Stepped:Connect(function(...)
    if Client.Character then
       local Character = Client.Character
       for i, v in pairs(Character:GetChildren()) do
          if v:IsA("BasePart") then
             v.CanCollide = false
          end
       end
    end
end)
                  
if DisableEffects then
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
end
                  
getgenv().KillSwitch = function(...)
   Thread_Function1.close()
   Thread_Function2.close()
   getgenv().DEffects:Disconnect()
   getgenv().Noclip:Disconnect()
   warn("Closed Thread 1", Thread_Function1.status)
   warn("Closed Thread 2", Thread_Function1.status)
   warn("Disconnected ChildAdded {Effects}")
   warn("Disconnected Stepped {Noclip}")
   for i, v in pairs(getgenv().OriginalEffects) do
      v:Clone().Parent = Effects
   end
end
