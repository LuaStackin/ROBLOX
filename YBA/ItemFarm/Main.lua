if getgenv().Settings == nil then
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/AutoMenu.lua"))()

if getgenv().Settings["AutoHop"] then
   wait(getgenv().Settings["HopWait"])
   if getgenv().Settings["HopCancel"] then
      warn("Auto Hop Cancelled!")
   else
      loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/Hop.lua"))().ServerHop()
   end
end
