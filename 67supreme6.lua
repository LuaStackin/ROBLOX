local CurrentSubject = nil 
local LastSubject = nil 
 
local Characters = workspace.Characters:GetChildren()
local CurrentIndex = 1

local spectating = true
game:GetService('RunService').RenderStepped:Connect(function()
    Characters = workspace.Characters:GetChildren()

	game.Players.LocalPlayer.CameraMode = 'Classic'
	game.Players.LocalPlayer.CameraMaxZoomDistance = 1000

	game.Lighting.GlobalShadows = false
	game.Lighting.Brightness = 1000

	if CurrentSubject then
		workspace.CurrentCamera.CameraSubject = CurrentSubject
	else
		local character = game.Players.LocalPlayer.Character

		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				workspace.CurrentCamera.CameraSubject = humanoid
			end
		end
	end

end)
 
local Players = game:GetService("Players") 
 
local player = Players.LocalPlayer 
local playerGui = player:WaitForChild("PlayerGui") 
 
-- Create ScreenGui 
local screenGui = Instance.new("ScreenGui") 
screenGui.Name = "SpectateUI" 
screenGui.ResetOnSpawn = false 
screenGui.Parent = playerGui 
 
-- Main container 
local container = Instance.new("Frame") 
container.Name = "ButtonContainer" 
container.Size = UDim2.new(0, 400, 0, 100) 
container.Position = UDim2.new(0.5, -200, 0.5, -50) 
container.BackgroundTransparency = 1 
container.Parent = screenGui 
 
----------------------------------------------------------------
-- NAME TAG
----------------------------------------------------------------

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "SpectatedName"
nameLabel.Size = UDim2.new(1, 0, 0, 35)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = ""
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextStrokeTransparency = 0.5
nameLabel.Parent = container

----------------------------------------------------------------
-- BUTTON CONTAINER
----------------------------------------------------------------

local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "Buttons"
buttonContainer.Size = UDim2.new(1, 0, 0, 60)
buttonContainer.Position = UDim2.new(0, 0, 0, 40)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = container

-- Layout 
local layout = Instance.new("UIListLayout") 
layout.FillDirection = Enum.FillDirection.Horizontal 
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center 
layout.VerticalAlignment = Enum.VerticalAlignment.Center 
layout.Padding = UDim.new(0, 10) 
layout.Parent = buttonContainer 
 
-- Function to create buttons 
local function createButton(name, text, width) 
	local button = Instance.new("TextButton") 
	button.Name = name 
	button.Size = UDim2.new(0, width, 0, 55) 
	button.BackgroundColor3 = Color3.fromRGB(35, 35, 35) 
	button.BackgroundTransparency = 0.1 
	button.BorderSizePixel = 0 
	button.Text = text 
	button.TextColor3 = Color3.fromRGB(255, 255, 255) 
	button.TextScaled = true 
	button.Font = Enum.Font.GothamBold 
	button.AutoButtonColor = true 
	button.Parent = buttonContainer 
 
	-- Rounded corners 
	local corner = Instance.new("UICorner") 
	corner.CornerRadius = UDim.new(0, 10) 
	corner.Parent = button 
 
	-- Outline 
	local stroke = Instance.new("UIStroke") 
	stroke.Color = Color3.fromRGB(90, 90, 90) 
	stroke.Thickness = 1.5 
	stroke.Parent = button 
 
	return button 
end 
 
local leftButton = createButton("LeftButton", "◀", 55) 
local spectateButton = createButton("SpectateToggle", "SPECTATE", 180) 
local teleportButton = createButton("TeleportTo", "TELEPORT TO", 180)
local rightButton = createButton("RightButton", "▶", 55) 


----------------------------------------------------------------
-- SPECTATE SYSTEM
----------------------------------------------------------------

local spectating = false
local currentIndex = 1


-- Get something that the camera can spectate
local function getSpectateSubject(character)
	if not character then
		return nil
	end

	-- Otherwise find the first BasePart
	local basePart = character:FindFirstChildWhichIsA("BasePart", true)

	if basePart then
		return basePart
	end


	-- Prefer Humanoid
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		return humanoid
	end

	return nil
end


-- Update the name above the buttons
local function updateNameLabel()
	if not CurrentSubject then
		nameLabel.Text = ""
		return
	end

	-- CurrentSubject will either be a Humanoid or BasePart.
	-- Its parent should be the character/NPC.
	local character = CurrentSubject.Parent

	if character then
		nameLabel.Text = character.Name
	else
		nameLabel.Text = ""
	end
end

leftButton.MouseButton1Click:Connect(function()

	if not spectating then
		return
	end

    local NextIndex = CurrentIndex - 1
    if 0 >= NextIndex or not Characters[NextIndex] then
        return warn('Invalid Index')
    end
    
    CurrentIndex = CurrentIndex - 1

	if Characters[NextIndex] then
        CurrentSubject = Characters[NextIndex]:FindFirstChildOfClass('BasePart') or Characters[NextIndex]:FindFirstChildOfClass('Humanoid') or game.Players.LocalPlayer.Character
        updateNameLabel()
    end
end)


----------------------------------------------------------------
-- RIGHT BUTTON
----------------------------------------------------------------

rightButton.MouseButton1Click:Connect(function()
	if not spectating then
		return
	end

    local NextIndex = CurrentIndex + 1
    if not Characters[NextIndex] then
        return warn('Invalid Index')
    end

    CurrentIndex += 1

	if Characters[NextIndex] then
        CurrentSubject = Characters[NextIndex]:FindFirstChildOfClass('BasePart') or Characters[NextIndex]:FindFirstChildOfClass('Humanoid') or game.Players.LocalPlayer.Character
        updateNameLabel()
    end
end)


----------------------------------------------------------------
-- TELEPORT TO BUTTON
----------------------------------------------------------------

teleportButton.MouseButton1Click:Connect(function()

	if not CurrentSubject then
		return
	end

	local character = CurrentSubject.Parent
	local localCharacter = player.Character

	if character and localCharacter then
		local targetRoot = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart", true)
		local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")

		if targetRoot and localRoot then
			localRoot.CFrame = targetRoot.CFrame
		end
	end

end)


----------------------------------------------------------------
-- SPECTATE TOGGLE
----------------------------------------------------------------

spectateButton.MouseButton1Click:Connect(function()

	if spectating then
		spectating = false

		LastSubject = CurrentSubject
		CurrentSubject = nil

		nameLabel.Text = ""
		spectateButton.Text = "SPECTATE"
	else
		spectating = true
		updateNameLabel()
	end

end)
