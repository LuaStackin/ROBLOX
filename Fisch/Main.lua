local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local Shaking = false
local CastChecking = false

local SetCharacter = function(Frame)
   Character.HumanoidRootPart.CFrame = Frame
end

local SelectButton = function(ShakeButton)
   if game:GetService("GuiService").GuiNavigationEnabled == false then
      game:GetService("GuiService").GuiNavigationEnabled = true
   end
   game:GetService("GuiService").SelectedObject = ShakeButton
   return true 
end

local FireButton = function(...)
   return function()
      VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
      VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
   end
end

local GetRod = function(...)
   for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
      if v.Name:lower():find("rod") and v:IsA("Tool") then
         return true, v
      end
   end
   return false, nil
end

local EquipRod = function(...)
   for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
      if v.Name:lower():find("rod") and v:IsA("Tool") then
         v.Parent = game.Players.LocalPlayer.Character
         return true
      end
   end
   return false
end

local InstantCatch = function(...)
   return game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, true)
end

local Shake = function(...)
   if game.Players.LocalPlayer.PlayerGui:FindFirstChild("shakeui") then
      Shaking = true
      pcall(function(...)
          local shakeui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("shakeui")
          if shakeui.safezone:FindFirstChild("button") then
             local button = shakeui.safezone.button
             SelectButton(button)
             FireButton()()
          end
      end)
   else
      Shaking = false
   end
end

local Cast = function(...)
   if CastChecking then return end
   pcall(function(...)
      CastChecking = true
      local Success, Rod = GetRod()
      if not Success then
         local Attempt = EquipRod()
         if not Attempt then
            return
         else
	    Success, Rod = GetRod()
            if not Success then
               return
            else
               Rod.events.reset:FireServer(0)
               Rod.events.cast:FireServer(100.5)
               wait(1.5)
            end
         end
      else
         Rod.events.reset:FireServer(0)
         Rod.events.cast:FireServer(100.5)     
         wait(1.5) 
      end
      CastChecking = false
   end)
   CastChecking = false
end

local InstantFunction = function(Descendant)
    if Descendant.Name == "shakeui" then
       local Timeout = 0
       repeat wait(.5) 
            Timeout = Timeout + 1
            InstantCatch() 
       until Timeout == 20
    end
end

local CFramePosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local CheckStatus = function(...)
   pcall(SetCharacter, CFramePosition)
   if Shaking == false then
      Cast()
   end
end 

game.Players.LocalPlayer.PlayerGui.DescendantRemoving:Connect(InstantFunction)

RunService.RenderStepped:Connect(CheckStatus)
RunService.RenderStepped:Connect(Shake)
