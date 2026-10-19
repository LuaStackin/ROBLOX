--// Disconnect Old Script Connections
if _G.AutoFarmScriptConnections ~= nil then
    _G.AutoFarmScriptConnections[1]:Disconnect()
    _G.AutoFarmScriptConnections[2]:Disconnect()

    task.cancel(_G.AutoFarmScriptConnections[3])
    _G.AutoFarmScriptConnections[4]:Disconnect()

    if _G.AutoFarmScriptConnections[5] ~= nil then
        for _, Connection in _G.AutoFarmScriptConnections[5] do
            pcall(function()
                Connection:Disconnect()
            end)
        end
    end

    _G.AutoFarmScriptConnections = nil
end

--// Services
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')

--// Variables
local Settings = {MurdererCheck = true, Tween = true, Connections = {}}
local Container, Murderer, CurrentCoin, CurrentTween;

local Player = Players.LocalPlayer

--// Functions
local function ContainerCheck(Child)
    if Child:IsA('Model') then
        local CoinContainer = Child:WaitForChild('CoinContainer', 15)
        if CoinContainer then
            Container = CoinContainer
            print('Found Container')
        end
    end
end

local function MurdererCheck(Player)
    local Connection; Connection = Player:WaitForChild('Backpack').ChildAdded:Connect(function(Tool)
        task.wait()
        if Tool.Name == 'Knife' then
            Murderer = Player
            warn('Murderer changed to', Player.Name)
        end
    end)

    if _G.AutoFarmScriptConnections then
        table.insert(_G.AutoFarmScriptConnections[4], Connection)
    else
        table.insert(Settings.Connections, Connection)
    end
end

local function NoclipRuntime()
    local Humanoid = Player.Character and Player.Character:FindFirstChild('Humanoid')
    if Humanoid then 
        return Humanoid:ChangeState(11)
    end
end

local function HumanoidRootPart()
    return (Player.Character and Player.Character:FindFirstChild('HumanoidRootPart'))
end

local function Tween(String)
    if String == 'Cancel' and CurrentTween and CurrentTween.PlaybackState ~= Enum.PlaybackState.Cancelled then
        CurrentCoin = nil
        return CurrentTween:Cancel()
    end

    if String == 'Create' and HumanoidRootPart() and (CurrentTween.PlaybackState == Enum.PlaybackState.Completed or CurrentTween.PlaybackState == Enum.PlaybackState.Cancelled) then
        CurrentTween = TweenService:Create(HumanoidRootPart(), TweenInfo.new(1), {Position = CurrentCoin.Position})
        return CurrentTween:Play()
    end
end

--// Connections
local ChildAdded; ChildAdded = workspace.ChildAdded:Connect(ContainerCheck)
local PlayerAdded; PlayerAdded = Players.PlayerAdded:Connect(MurdererCheck)
local Stepped; Stepped = RunService.Stepped:Connect(NoclipRuntime)

local Runtime; Runtime = task.spawn(function()
    while task.wait(0.25) do
        local Success, Error = pcall(function()
            local Alive = Player:GetAttribute('Alive') 
            if Alive then
                return Tween('Cancel')
            end

            if Container and Alive then
                if (not CurrentCoin) or (CurrentCoin and CurrentCoin.Parent == nil) then
                    local Children = Container:GetChildren()
                    CurrentCoin = Children[math.random(1, #Children)]
                end

                if CurrentCoin then
                    local MurdererCharacter = Murderer and Murderer.Character
                    if Settings.MurdererCheck and MurdererCharacter then
                        local MurdererPart = MurdererCharacter:FindFirstChild('HumanoidRootPart') or MurdererCharacter:FindFirstChildWhichIsA('BasePart')
                        if MurdererPart and 30 >= (MurdererPart.Position - CurrentCoin.Position).magnitude then
                            return Tween('Cancel')
                        end
                    end

                    return Tween('Create')
                end

                warn('No Coin RN')
            end
        end)

        if not Success then
            warn(`[Error Occured: {Error}]`)
        end
    end
end)


--// Connection Storage
_G.AutoFarmScriptConnections = {[1] = ChildAdded, [2] = PlayerAdded, [3] = Runtime, [4] = Stepped, [5] = Settings.Connections}

--// Final Checks
for _, Player in Players:GetPlayers() do
    MurdererCheck(Player)

    local Backpack = Player:FindFirstChild('Backpack')
    local Character = Player.Character

    if Character and Character:FindFirstChild('Knife') then
        Murderer = Player
    end

    if Backpack and Backpack:FindFirstChild('Knife') then
        Murderer = Player
    end
end

for _, Child in workspace:GetChildren() do
    task.spawn(ContainerCheck, Child)
end
