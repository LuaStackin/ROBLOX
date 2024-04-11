if getgenv().HopSettings == nil then
   return false, "Settings are missing!"
end

if getgenv().RF == nil then
   return false, "Remote Function is missing!"
end

if getgenv().OCI == nil then
   return false, "Function Hook is missing!"
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/TpBypass.lua"))()
getgenv().RF.OnClientInvoke = getgenv().OCI
if game.Players.LocalPlayer.Character then
   local Remote = game.Players.LocalPlayer.Character:WaitForChild("RemoteEvent", 5)
   if Remote ~= nil then
      Remote:FireServer("PressedPlay")
      if game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen") then
         repeat wait() until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1")
         wait(1)
         loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/AutoMenu.lua"))()
      end
   else
      loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/AutoMenu.lua"))()
   end
else
   loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/AutoMenu.lua"))()
end

if getgenv().HopSettings["AutoHop"] then
   wait(getgenv().HopSettings["HopWait"])
   if getgenv().HopSettings["HopCancel"] then
      warn("Auto Hop Cancelled!")
   else
      loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/Hop.lua"))().ServerHop()
   end
end
