local RemoteFunction = function()
   if game:GetService("Players").LocalPlayer.Character then
      local Character = game:GetService("Players").LocalPlayer.Character
      if Character:FindFirstChild("RemoteFunction") then
         return Character:FindFirstChild("RemoteFunction")
      end
   end 
end

local RemoteEvent = function()
   if game:GetService("Players").LocalPlayer.Character then
      local Character = game:GetService("Players").LocalPlayer.Character
      if Character:FindFirstChild("RemoteEvent") then
         return Character:FindFirstChild("RemoteEvent")
      end
   end 
end

local GetStandSkin = function()
   return RemoteFunction():InvokeServer("ReturnStandSkin", "Stand")
end

local WorthinessInfo = function()
   return RemoteFunction():InvokeServer("ReturnSkillInfoInTree", {
     ["Type"] = "Character",
     ["Skills"] = {[1] = "Worthiness V"}
   })
end

local WorthinessV = function()
   return RemoteFunction():InvokeServer("LearnSkill", {
     ["SkillTreeType"] = "Character", 
     ["Skill"] = "Worthiness V"
   })
end

local ClickButton = function(button, manual)
    for i, v in pairs(getconnections(button.MouseButton1Click)) do
        if manual then
            v.Function()
        else
            v:Fire()
        end
    end
end

local UseRokakaka = function() 
   if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rokakaka") then
      local Roka = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rokakaka")
      if game:GetService("Players").LocalPlayer.Character then
         game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(Roka)
         wait(1)
         Roka:Activate()  
         Roka:Deactivate()      
         wait(1)
	 local Dialogue = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("DialogueGui"):WaitForChild("Frame")
         if Dialogue:WaitForChild("Title").Text == "Rokakaka" then
            ClickButton(Dialogue:WaitForChild("Options"):WaitForChild("Option1"):WaitForChild("TextButton"))
         end
	 return true, "Success"
      end
   end
   return false, "Could not find Item"
end

local UseRibCage = function() 
   if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rib Cage of The Saint's Corpse") then
      local RibCage = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rib Cage of The Saint's Corpse")
      if game:GetService("Players").LocalPlayer.Character then
         game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(RibCage)
         wait(1)
         RemoteEvent():FireServer("EndDialogue", {
           ["NPC"] = "Rib Cage of The Saint's Corpse", 
	   ["Option"] = "Option1", 
           ["Dialogue"] = "Dialogue2"
         })
	 return true, "Success"
      end
   end
   return false, "Could not find Item"
end

local Notify = function(Title, Text, Duration)
   return game:GetService("StarterGui"):SetCore("SendNotification", {
     Title = Title,
     Text = Text,
     Duration = Duration
   })
end

local Connection;
local Start = function(...)
    local Skin = tostring(GetStandSkin())
    if ((Skin:lower() == "none" or Skin == "None") and Skin ~= "nil") then
       local Success, Message = UseRokakaka()
       if not Success and Message ~= "Could not find Item" then
          repeat wait()
 	   Success = UseRokakaka()
	   if tostring(GetStandSkin()) ~= "nil" then
              Success = false
           end
          until Success
       elseif not Success and Message == "Could not find Item" then
          Connection:Disconnect()
          Notify("Farm Error", "Out of Rokas! Stopped Script.", 15)
          return
       end
    elseif Skin == "nil" then
       WorthinessV()
       local Success, Message = UseRibCage()
       if not Success and Message ~= "Could not find Item" then
          repeat wait()
 	   Success = UseRibCage()
          until Success
       elseif not Success and Message == "Could not find Item" then
          Connection:Disconnect()
          Notify("Farm Error", "Out of Rib Cages! Stopped Script.", 15)
          return
       end
       repeat wait() until tostring(GetStandSkin()) ~= "nil"
       warn("No Skin Rolled")
       wait(1)
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
    else
       Notify("Farm Success", ("You got a skin: " .. Skin), 15)   
    end
end

Connection = game.Players.LocalPlayer.CharacterAdded:Connect(function(...)
    wait(1)
    Start()
end)
Notify("Starting Farm", "Starting Shortly!", 5)
Start()
