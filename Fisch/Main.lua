--[[ 
	MADE IN LITERALLY 30 MINUTES, ONLY TOOK THAT LONG BECAUSE IM DOING THIS ON AN EMULATOR LMAO,
	THIS GAMES ANTICHEAT SUCKS SO BAD. 

	I DONT RECCOMMEND EXPLOITING IF YOU LIKE IT, I DONT EXPLOIT ON MY MAIN BUT I MADE THIS SCRIPT
	PURELY TO JUST TEST HOW BAD ITS ANTICHEAT WAS.

	-- > USE AT YOUR OWN RISK, WILL PROBABLY BE OUTDATED IN A MONTH OR SO.
]]--

local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local Shaking = false
local CastChecking = false

local SetCharacter = function(Character, Frame)
   Character.HumanoidRootPart.CFrame = Frame
end

local SelectButton = function(ShakeButton)
   if game:GetService("GuiService").GuiNavigationEnabled == false then
      game:GetService("GuiService").GuiNavigationEnabled = true
   end
   game:GetService("GuiService").SelectedObject = ShakeButton
   if tostring(game:GetService("GuiService").SelectedObject) == "button" then 
       return true 
   else
       return false
   end
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
             local Selected = SelectButton(button)
             if Selected then 
		FireButton()()
	     end
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
       local PlayerUI = Descendant.Parent
       local Timeout = 0
       repeat wait(.5) 
            Timeout = Timeout + 1
            InstantCatch() 
       until not PlayerUI:FindFirstChild("reel")
    end
end

local CFramePosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local CheckStatus = function(...)
   pcall(SetCharacter, game.Players.LocalPlayer.Character, CFramePosition)
   if Shaking == false then
      Cast()
   end
end 

game.Players.LocalPlayer.PlayerGui.DescendantRemoving:Connect(InstantFunction)

RunService.Stepped:Connect(CheckStatus)
RunService.RenderStepped:Connect(Shake)
