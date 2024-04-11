-- loading

if not game:IsLoaded() then game.Loaded:Wait() end
if game.GameId ~= 1016936714 then return end

-- services

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- variables

local Client = Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

-- functions

local function click(button, manual)
    for i, v in pairs(getconnections(button.MouseButton1Click)) do
        if manual then
            v.Function()
        else
            v:Fire()
        end
    end
    print("Clicked", button)
end

-- main lol

if PlayerGui:FindFirstChild("LoadingScreen") and not PlayerGui:FindFirstChild("LoadingScreen1") then
   local Play = PlayerGui:FindFirstChild("LoadingScreen"):WaitForChild("Frames"):WaitForChild("Main"):WaitForChild("Play")
   click(Play, false)
   return true
end

local AssetLoading = PlayerGui:WaitForChild("LoadingScreen1", 3)
if AssetLoading ~= nil then
   for i, v in pairs(AssetLoading:GetDescendants()) do
      if v:IsA("ImageButton") or v:IsA("TextButton") then
         click(v, false)
      end
   end
   local Play = PlayerGui:WaitForChild("LoadingScreen"):WaitForChild("Frames"):WaitForChild("Main"):WaitForChild("Play")
   click(Play, false)
end

return true
