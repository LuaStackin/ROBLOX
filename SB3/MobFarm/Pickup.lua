local Drops = game:GetService("ReplicatedStorage").Drops
local PickupRemote = game:GetService("ReplicatedStorage").Systems.Drops.Pickup

local ItemList = require(game:GetService("ReplicatedStorage").Systems:WaitForChild("Items"))
local Success, Error = pcall(function(...)
    ItemList = ItemList.GetItemList()
end)

local AllowWeapons = false
local AllowArmor = false

local PickupFunc = function(Drop)
    wait(2)
    for i, v in pairs(ItemList) do
       if i:lower() == tostring(Drop):lower() then
          if v.Category == "Material" then
             PickupRemote:FireServer(Drop)
          end
          if v.Category == "Weapon" and AllowWeapons then
             PickupRemote:FireServer(Drop)
          end
          if v.Category == "Armor" and AllowArmor then
             PickupRemote:FireServer(Drop)
          end
       end
    end
end

getgenv().Pickup = Drops.ChildAdded:Connect(PickupFunc)
local Fake_Func = coroutine.create(PickupFunc)
for i, v in pairs(Drops:GetChildren()) do
   coroutine.resume(Fake_Func, v)
end
