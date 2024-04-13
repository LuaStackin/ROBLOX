if getgenv()["Settings"] == nil then
	getgenv()["Settings"] = {
		["HopSettings"] = {
			["Enabled"] = false,
			["HopTimer"] = 20,
			["Cancel"] = false
		},
		["Callback"] = function(Name)
			warn(Name, "Collected!")
		end,
		["Items"] = "Default"
	}
end

local Hook
local ServiceTable = {
	["Players"] = game:GetService("Players"),
	["RunService"] = game:GetService("RunService")
}

local TableTable = {
	["QueueTable"] = {},
	["ItemTable"] = {
		["Lucky Arrow"] = true,
		["Lucky Stone Mask"] = true,
		["Mysterious Arrow"] = false,
		["Rokakaka"] = false,
		["Rib Cage of The Saint's Corpse"] = false,
		["Zepellin's Headband"] = false,
		["Quinton's Glove"] = false,
		["Pure Rokakaka"] = false,
		["Steel Ball"] = false,
		["Stone Mask"] = false,
		["Ancient Scroll"] = false,
		["Dio's Diary"] = false, 
		["Diamond"] = false,
		["Gold Coin"] = false
	}
}

local ExtraFunctionTable = {
	["Teleport"] = function(C)
		local Success, Error = pcall(function(...)
			if ServiceTable["Players"].LocalPlayer.Character then
				local A = {["Character"] = ServiceTable["Players"].LocalPlayer.Character}
				if A["Character"]:FindFirstChild("HumanoidRootPart") then
					A["Character"]["HumanoidRootPart"].CFrame = C
				end
			end
		end)
		return Success, (Error or "Success")
	end,
	["RegisterPlaying"] = function(...)
		local Success, Error = pcall(function(...)
			if ServiceTable["Players"].LocalPlayer.Character then
				local A = {["Character"] = ServiceTable["Players"].LocalPlayer.Character, ["PlayerGui"] = ServiceTable["Players"].LocalPlayer.PlayerGui}
				if A["Character"]:FindFirstChild("RemoteEvent") and A["PlayerGui"]:FindFirstChild("LoadingScreen") then
					A["Character"]["RemoteEvent"]:FireServer("PressedPlay")
					repeat wait() until not A["PlayerGui"]:FindFirstChild("LoadingScreen1")
					loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/ItemFarm/AutoMenu.lua"))()
				end
			end
		end)
		return Success, (Error or "Success") 
	end
}

local FunctionTable = {
	["QueueFunction"] = function(N, C, P)
		table.insert(TableTable["QueueTable"], {N = N, C = C, P = P})
	end,
	["SearchFunction"] = function(Callback)
		for i, v in pairs(TableTable["QueueTable"]) do
			ExtraFunctionTable["Teleport"](v.C) 
			wait(v.P.HoldDuration + 0.1)
			if v.P:FindFirstChild("RemoteEvent") then
				local Event = v.P:FindFirstChild("RemoteEvent")
				Event:FireServer()
				wait(1.5)
				if Callback ~= nil then
					Callback(v.N)
				end 
				table.remove(TableTable["QueueTable"], i)
			else
				table.remove(TableTable["QueueTable"], i)
				break
			end
		end
	end,
	["TeleportBypass"] = function(self, ...)
		local Args = {...}
		if tostring(self) == "Returner" and Args[1] == "idklolbrah2de" then
			warn("...")
			return "  ___XP DE KEY"
		end
		return Hook(self, ...)
	end,
	["HopFunction"] = function(...)
		local A = getgenv()["Settings"]["HopSettings"]
		if A["Enabled"] then
			wait(A["HopTimer"]) 
			if not A["Cancel"] then
				return true, "Hopping Servers"
			else
				return false, "Server Hop Stopped"
			end
		end
	end,
	["HopControl"] = function(HF)
		warn("wow", HF)

		local FS, Success, Reason = pcall(HF)
		warn(FS, Success, Reason)
		if not Success then
			repeat wait() until (getgenv()["Settings"]["HopFix"] ~= nil)
			getgenv()["Settings"]["HopSettings"]["Cancel"] = false
			local Success, Reason = HF()
			if Success then
				loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/v1/Hop.lua"))().ServerHop()
			end
		else
			loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/v1/Hop.lua"))().ServerHop()
		end
	end
}

local ITable = {
	["ItemSpawner"] = game:GetService("ReplicatedStorage"):WaitForChild("ItemSpawn"),
	["ItemFunction"] = function(...)
		local Args = {...}
		local Success, Error = pcall(function()
			if Args[1] == "Item_Spawned" then
				local N = Args[2]["Replica"]
				local C = Args[2]["CFrame"]
				local P = Args[2]["CD"]
				if TableTable["ItemTable"][tostring(N)] == true then
					FunctionTable["QueueFunction"](N, C, P)
				else
					warn(N, "Not Being Collected!")
				end
			end
		end)
		if not Success then
			warn("CInvoke Error:", Error)
		end
		return unpack(Args)
	end
}

if getgenv()["Settings"]["Items"] ~= "Default" then
	for item, value in pairs(getgenv()["Settings"]["Items"]) do
		if value ~= false and value ~= true then
			value = true
		end
		TableTable["ItemTable"][item] = value
	end
	local NotCollected = {}
	local Collecting = {}
	warn(NotCollected, Collecting, 1)
	for i, v in pairs(TableTable["ItemTable"]) do
	   	if v == false then
			table.insert(NotCollected, tostring(i))
		elseif v == true 
			table.insert(Collecting, tostring(i))
		end
	end
	warn(NotCollected, Collecting, 2)
	warn("The following items are not being collected:", table.concat(NotCollected, ", "))
	warn("Collecting these items:", table.concat(Collecting, ", "))
else
	warn("Item Default's Set")
end

Hook = hookmetamethod(game, "__namecall", FunctionTable["TeleportBypass"])
ITable["ItemSpawner"].OnClientInvoke = ITable["ItemFunction"]

Thread = coroutine.create(FunctionTable["HopControl"])
coroutine.resume(Thread, FunctionTable["HopFunction"])

RSuccess, RError = ExtraFunctionTable["RegisterPlaying"]()
if not RSuccess then
	warn("PRegister Error:", RError)
else
	warn("PRegister Success!")
end

while true do
	local SFSuccess, SFError = pcall(FunctionTable["SearchFunction"], function(Name)
		warn(Name)
	end)
	if not SFSuccess then
		warn("QSystem Error:", SFError)
	end
	wait(.5)
end
