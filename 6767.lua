local CurrentSubject = nil 
local LastSubject = nil 
 
local Characters = workspace.Characters 
local characterList = {} 
 
-- Initial characters 
for _, character in ipairs(Characters:GetChildren()) do 
	table.insert(characterList, character) 
end 
 
-- New character 
Characters.ChildAdded:Connect(function(character) 
	table.insert(characterList, character) 
end) 
 
-- Removed character 
Characters.ChildRemoved:Connect(function(character) 
	for index, existingCharacter in ipairs(characterList) do 
		if existingCharacter == character then 
			table.remove(characterList, index) 
			break 
		end 
	end 
end) 
 
game:GetService('RunService').RenderStepped:Connect(function()

	game.Players.LocalPlayer.CameraMode = 'Classic'
	game.Players.LocalPlayer.CameraMaxZoomDistance = 1000

	game.Lighting.GlobalShadows = false
	game.Lighting.Brightness = 100

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


-- Find a valid character
local function findValidIndex()
	if #characterList == 0 then
		return nil
	end

	for i = 1, #characterList do
		
		local index = ((currentIndex - 1 + i - 1) % #characterList) + 1
		local character = characterList[index]

		if character and character.Parent then
			
			local subject = getSpectateSubject(character)

			if subject then
				return index
			end
		end
	end

	return nil
end


-- Spectate a specific character
local function spectateCharacter(index)
	if #characterList == 0 then
		CurrentSubject = nil
		updateNameLabel()
		return
	end

	-- Wrap around
	if index > #characterList then
		index = 1
	elseif index < 1 then
		index = #characterList
	end

	currentIndex = index

	local validIndex = findValidIndex()

	if not validIndex then
		CurrentSubject = nil
		updateNameLabel()
		return
	end

	currentIndex = validIndex

	local character = characterList[currentIndex]
	local subject = getSpectateSubject(character)

	if subject then
		LastSubject = CurrentSubject
		CurrentSubject = subject

		updateNameLabel()

		print("Spectating:", character.Name)
		print("Index:", currentIndex)
		print("Subject:", subject:GetFullName())
	end
end


----------------------------------------------------------------
-- LEFT BUTTON
----------------------------------------------------------------

leftButton.MouseButton1Click:Connect(function()

	if not spectating then
		return
	end

	spectateCharacter(currentIndex - 1)

end)


----------------------------------------------------------------
-- RIGHT BUTTON
----------------------------------------------------------------

rightButton.MouseButton1Click:Connect(function()

	if not spectating then
		return
	end

	spectateCharacter(currentIndex + 1)

end)


----------------------------------------------------------------
-- SPECTATE TOGGLE
----------------------------------------------------------------

spectateButton.MouseButton1Click:Connect(function()

	if spectating then

		-- Stop spectating
		spectating = false

		LastSubject = CurrentSubject
		CurrentSubject = nil

		nameLabel.Text = ""
		spectateButton.Text = "SPECTATE"

		-- Return camera to local player
		local character = player.Character

		if character then

			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				workspace.CurrentCamera.CameraSubject = humanoid
			end

		end

	else

		-- Start spectating
		spectating = true

		spectateButton.Text = "STOP SPECTATING"

		currentIndex = 1

		local validIndex = findValidIndex()

		if validIndex then

			currentIndex = validIndex
			spectateCharacter(currentIndex)

		else

			spectating = false
			spectateButton.Text = "SPECTATE"
			nameLabel.Text = ""

			warn("No valid characters/NPCs to spectate.")

		end
	end

end)


----------------------------------------------------------------
-- HANDLE CURRENT CHARACTER BEING REMOVED
----------------------------------------------------------------

spectateButton.MouseButton1Click:Connect(function()

	if spectating then

		-- STOP SPECTATING
		spectating = false

		LastSubject = CurrentSubject
		CurrentSubject = nil

		nameLabel.Text = ""
		spectateButton.Text = "SPECTATE"

		-- Return camera to local player
		local character = player.Character

		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				workspace.CurrentCamera.CameraSubject = humanoid
			end
		end

		return
	end


	-- START SPECTATING
	if #characterList == 0 then
		warn("There are no objects inside workspace.Characters")
		return
	end

	spectating = true
	spectateButton.Text = "STOP SPECTATING"

	currentIndex = 1


	-- Find the first usable character
	for i, character in ipairs(characterList) do

		if character and character.Parent then

			-- First priority: Humanoid
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then

				currentIndex = i
				LastSubject = CurrentSubject
				CurrentSubject = humanoid

				nameLabel.Text = character.Name

				workspace.CurrentCamera.CameraSubject = CurrentSubject

				print("Spectating:", character.Name)
				print("Subject:", CurrentSubject:GetFullName())

				return
			end


			-- Second priority: first BasePart
			local basePart = character:FindFirstChildWhichIsA("BasePart", true)

			if basePart then

				currentIndex = i
				LastSubject = CurrentSubject
				CurrentSubject = basePart

				nameLabel.Text = character.Name

				workspace.CurrentCamera.CameraSubject = CurrentSubject

				print("Spectating:", character.Name)
				print("Subject:", CurrentSubject:GetFullName())

				return
			end

		end

	end


	-- Nothing could be spectated
	spectating = false
	spectateButton.Text = "SPECTATE"
	nameLabel.Text = ""

	warn("Couldn't find a Humanoid or BasePart to spectate.")

end)


----------------------------------------------------------------
-- HANDLE NEW CHARACTERS
----------------------------------------------------------------

Characters.ChildAdded:Connect(function(character)
	print("New character added:", character.Name)
end)
