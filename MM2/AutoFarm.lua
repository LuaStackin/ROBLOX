--// Disconnect Old Script Connections
if _G.AutoFarmScriptConnections ~= nil then
    _G.AutoFarmScriptConnections[1]:Disconnect()
    _G.AutoFarmScriptConnections[2]:Disconnect()

    task.cancel(_G.AutoFarmScriptConnections[3])

    if _G.AutoFarmScriptConnections[4] ~= nil then
        for _, Connection in _G.AutoFarmScriptConnections[4] do
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

local function HumanoidRootPart()
    return (Player.Character and Player.Character:FindFirstChild('HumanoidRootPart'))
end

local function Tween(String)
    if String == 'Cancel' and CurrentTween then
        CurrentCoin = nil
        CurrentTween:Cancel()
    end

    local HRP = HumanoidRootPart()
    if String == 'Create' and HRP then
        CurrentTween = TweenService:Create(HRP, TweenInfo.new(1), {Position = CurrentCoin.Position})
        CurrentTween:Play()
    end
end

--// Connections
local ChildAdded; ChildAdded = workspace.ChildAdded:Connect(ContainerCheck)
local PlayerAdded; PlayerAdded = Players.PlayerAdded:Connect(MurdererCheck)

local Runtime; Runtime = task.spawn(function()
    while task.wait(0.25) do
        local Success, Error = pcall(function()
            if Container then
                warn(Container, Container.Parent)

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
_G.AutoFarmScriptConnections = {[1] = ChildAdded, [2] = PlayerAdded, [3] = Runtime, [4] = Settings.Connections}

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
