-- [V1, UI_CONTROLLER, UI_REQUIRE - XVA]
local UIC_Thread = coroutine.create(function(...)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/Twisted%20Murderer/UI_CONTROLLER.lua"))()
end)
local UIR_Thread = coroutine.create(function(...)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/Twisted%20Murderer/UI_REQUIRE.lua"))()
end)
coroutine.resume(UIC_Thread)
coroutine.resume(UIR_Thread)
warn("ThreadV1=" .. tostring(math.random(1,9999999) + math.random(50, 5000) / 100))
