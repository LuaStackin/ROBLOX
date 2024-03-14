-- services 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- variables

local Client = Players.LocalPlayer
local CanAttack = false

-- locations

local Mobs = workspace.Mobs
local Drops = ReplicatedStorage.Drops
local Effects = ReplicatedStorage.Systems.Effects
local WEffects = workspace.Effects
local MobSpawns = workspace.MobSpawns

-- Settings

local Mob = "Razor Boar" -- (Hell Hound, Cold Mammoth)
local Item = "All"
local HitDelay = 0.2 -- seconds
local MinDistance = 43 -- studs
local PositionDistance = 28

local DisableEffects = true
local BreakLoop = false

if getgenv().KillSwitch ~= nil then
   local Success, Error = pcall(getgenv().KillSwitch)
   if not Success then
      warn("Error Kill Switching:", Error)
   end
end

if getgenv().Settings ~= nil then
   local Settings = getgenv().Settings
   if Settings.Mob ~= nil then
      Mob = Settings.Mob  
      warn("Set Mob:", Mob)
   end
   if Settings.Item ~= nil then
      Item = Settings.Item  
      warn("Set Item:", Item)
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
      warn("Set Disable Effects:", tostring(DisableEffects))
   end
end

-- Remotes & Other

local Part = Instance.new("Part"); Part.Anchored = true; Part.Size = Vector3.new(25, 3, 25); Part.Parent = workspace;
local CombatRemote = ReplicatedStorage.Systems.Combat.PlayerAttack
local PickupRemote = ReplicatedStorage.Systems.Drops.Pickup

-- Connections

local RenderStepped = RunService.RenderStepped
local Stepped = RunService.Stepped
local Idled = Client.Idled

local ThreadCreate = coroutine.create
local ThreadClose = coroutine.close
local ThreadRun = coroutine.resume

local AttackMob = function(Mob, Root, Part)
   repeat wait()
        Root.CFrame = SelectedMob.HumanoidRootPart.CFrame * CFrame.new(0, -PositionDistance, 0)
        Part.CFrame = Root.CFrame * CFrame.new(0, -4, 0)
	CombatRemote:FireServer({[1] = Mob}) 
	wait(HitDelay)
   until 0 >= Mob:GetAttribute("HP") 
   Mob:Destroy()
   SelectedMob = nil   
   warn("Done, Selecting new mob.")
end

getgenv().MainRuntime = function(...)
    if Mobs:FindFirstChild(Mob) then
       SelectedMob = Mobs:FindFirstChild(Mob)
    end
    if SelectedMob ~= nil then
       local Root = nil
       if Client.Character then
          local Character = Client.Character
          if Character:FindFirstChild("HumanoidRootPart") then
             Root = Character:FindFirstChild("HumanoidRootPart")
          end
       end
       if Root ~= nil then
          Root.CFrame = SelectedMob.HumanoidRootPart.CFrame * CFrame.new(0, -PositionDistance, 0)
          Part.CFrame = Root.CFrame * CFrame.new(0, -4, 0)
          wait(1)
          AttackMob(SelectedMob, Root, Part)
       end
    end
end

local Thread_Function1 = ThreadCreate(function(...)
     local Function = getgenv().MainRuntime
     while true do
        local Success, Error = pcall(Function)
        if not Success then
           warn("Error Running Function:", Function, "// Error:", Error)
        end
        wait()
     end
end)

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

getgenv().AntiAFK = Idled:Connect(function(...)
     VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
     wait(1)
     VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)    
end) 

loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/SB3/MobFarm/Pickup.lua"))()

if DisableEffects then
   getgenv().DEffects = WEffects.ChildAdded:Connect(function(Effect)
       wait(.1)
       Effect:Destroy()
   end)

   if not getgenv().OriginalEffects then
      getgenv().OriginalEffects = Effects:Clone()
   end

   for i, v in pairs(Effects:GetChildren()) do
      v:Destroy()
   end
end

ThreadRun(Thread_Function1)

warn("Loading Complete.")
                  
getgenv().KillSwitch = function(...)
   ThreadClose(Thread_Function1)
   if DisableEffects then
      getgenv().DEffects:Disconnect()
      for i, v in pairs(getgenv().OriginalEffects) do
         v:Clone().Parent = Effects
      end
      warn("Disconnected ChildAdded {Effects}")
   end
   getgenv().Noclip:Disconnect()
   getgenv().Pickup:Disconnect()
   getgenv().AntiAFK:Disconnect()
   warn("Disconnected ChildAdded {Anti-AFK}")
   warn("Disconnected Stepped {Noclip}")
   warn("Disconnected ChildAdded {Pickup}")
end
