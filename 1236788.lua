local SpectateUI = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Previous = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Next = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Subject = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local Log = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Template = Instance.new("TextButton")

SpectateUI.Name = "SpectateUI"
SpectateUI.Parent = game.CoreGui
SpectateUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = SpectateUI
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.75, 0)
Main.Size = UDim2.new(0, 511, 0, 125)

Previous.Name = "Previous"
Previous.Parent = Main
Previous.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Previous.BorderColor3 = Color3.fromRGB(0, 0, 0)
Previous.BorderSizePixel = 0
Previous.Position = UDim2.new(0.0293542072, 0, 0.296000004, 0)
Previous.Size = UDim2.new(0, 149, 0, 50)
Previous.Font = Enum.Font.Sarpanch
Previous.Text = "Previous"
Previous.TextColor3 = Color3.fromRGB(255, 255, 255)
Previous.TextScaled = true
Previous.TextSize = 14.000
Previous.TextWrapped = true

UICorner.Parent = Previous

Next.Name = "Next"
Next.Parent = Main
Next.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Next.BorderColor3 = Color3.fromRGB(0, 0, 0)
Next.BorderSizePixel = 0
Next.Position = UDim2.new(0.679060638, 0, 0.296000004, 0)
Next.Size = UDim2.new(0, 149, 0, 50)
Next.Font = Enum.Font.Sarpanch
Next.Text = "Next"
Next.TextColor3 = Color3.fromRGB(255, 255, 255)
Next.TextScaled = true
Next.TextSize = 14.000
Next.TextWrapped = true

UICorner_2.Parent = Next

Subject.Name = "Subject"
Subject.Parent = Main
Subject.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Subject.BorderColor3 = Color3.fromRGB(0, 0, 0)
Subject.BorderSizePixel = 0
Subject.Position = UDim2.new(0.354207426, 0, 0.296000004, 0)
Subject.Size = UDim2.new(0, 152, 0, 50)
Subject.Font = Enum.Font.SourceSansBold
Subject.Text = "N/A"
Subject.TextColor3 = Color3.fromRGB(255, 255, 255)
Subject.TextScaled = true
Subject.TextSize = 14.000
Subject.TextWrapped = true

UICorner_3.Parent = Subject

Log.Name = "Log"
Log.Parent = SpectateUI
Log.AnchorPoint = Vector2.new(0.5, 0.5)
Log.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
Log.BorderSizePixel = 0
Log.Position = UDim2.new(0.152262449, 0, 0.480769217, 0)
Log.Size = UDim2.new(0, 206, 0, 328)

ScrollingFrame.Parent = Log
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, -0.00152434374, 0)
ScrollingFrame.Size = UDim2.new(0, 206, 0, 327)
ScrollingFrame.ScrollBarThickness = 0

UIListLayout.Parent = ScrollingFrame

Template.Name = "Template"
Template.Parent = ScrollingFrame
Template.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Template.BorderColor3 = Color3.fromRGB(0, 0, 0)
Template.BorderSizePixel = 0
Template.Size = UDim2.new(0, 206, 0, 28)
Template.Visible = false
Template.Font = Enum.Font.SourceSans
Template.Text = "Deciever - 08:32:12"
Template.TextColor3 = Color3.fromRGB(255, 255, 255)
Template.TextScaled = true
Template.TextSize = 14.000
Template.TextWrapped = true

-- Scripts:

local function AZTN_fake_script() -- SpectateUI.Handler 
	local script = Instance.new('LocalScript', SpectateUI)

	--[[ Core ]]--
	local UI = script.Parent
	
	--[[ Services ]]--
	local RunService = game:GetService('RunService')
	local Players = game:GetService('Players')
	
	--[[ Variables ]]--
	local Characters = workspace:WaitForChild('Characters')
	local Player = Players.LocalPlayer 
	
	local Spectating, Index = true, 1
	local MainFrame, LogFrame, CurrentCharacters = UI:WaitForChild('Main'), UI:WaitForChild('Log'), {}
		
	--[[ Functions ]]--
	local function Character()
		return Player.Character
	end
	
	local function Secondary()
		local Previous, Next = MainFrame:WaitForChild('Previous'), MainFrame:WaitForChild('Next')
		local ScrollingFrame, History = LogFrame:WaitForChild('ScrollingFrame'), {}
		
		Previous.MouseButton1Up:Connect(function()
			if CurrentCharacters[Index - 1] then
				Index = Index - 1
			else
				Index = #CurrentCharacters
			end
		end)
		
		Next.MouseButton1Up:Connect(function()
			if CurrentCharacters[Index + 1] then
				Index = Index + 1
			else
				Index = 1
			end		
		end)
		
		local CharTemplateIndex = 5000000000
		Characters.ChildAdded:Connect(function(Character)
			if #History >= 11 then
				History[1]:Destroy(); 
				table.remove(History, 1)
			end
			
			local Template = ScrollingFrame.Template:Clone()
			table.insert(History, Template)
			
			Template.Name = CharTemplateIndex - 1
			CharTemplateIndex -= 1
			
			Template.Text = `{Character.Name} - {os.date("%H:%M:%S")}`
			Template.Parent = ScrollingFrame
			
			Template.Visible = true
		end)
	end
	
	local function Main()
		local Camera = workspace.CurrentCamera
		CurrentCharacters = Characters:GetChildren()
		
		Player.CameraMode = Enum.CameraMode.Classic
	    Player.CameraMaxZoomDistance = 1000
		
		if not Spectating then
			Camera.CameraSubject = Character().Humanoid
			return
		end
		
		local Character = CurrentCharacters[Index]
		if Character then
			local SpectatePart = Character:FindFirstChildOfClass('BasePart') or Character:FindFirstChildOfClass('Humanoid')
			if not SpectatePart then
				return
			else
				Camera.CameraSubject = SpectatePart
				MainFrame.Subject.Text = Character.Name
			end
		end	
		
		return
	end
	
	--[[ Runtime ]]--
	RunService.RenderStepped:Connect(Main)
	Secondary()
end
coroutine.wrap(AZTN_fake_script)()
