local Hook; Hook = hookmetamethod(game, '__namecall', function(self, ...)
    --
    local Args = {...};
    --
    if getnamecallmethod() == 'FireServer' then
        --
        if Args[1] == 'SigL' then
            --
            warn('Blocked Ban Attempt - SigL')
            return
        end
        --
    end
    --
    if getnamecallmethod() == 'InvokeServer' then
        --
        if Args[1] == 'idklolbrah2de' then
            --
            warn('Tp Bypassed')
            return "  ___XP DE KEY"
        end
        --
    end    
    --
    return Hook(self, ...);
end)
--
local Key = "+__Z?  aayes30ur0sfx'a'anewfrikencodebro]wa]dpWD_    we=ight dena-0d=+mbleyeeth leh        vnv #$%#$& !1 Fcs yadda yada d;'k )#@)_!XSLDFKASblahDOL{AWya   PFGbcf________ - - - mPpep ok"
local ItemSpawn = game:GetService('ReplicatedStorage'):FindFirstChild('ItemSpawn');
--
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
		return Success, (Error or "Success Teleport")
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
		return Success, (Error or "Success RegisterPlaying") 
	end,
	["LuckyStopper"] = function(...)
		local Success, Error = pcall(function(...)
			if getgenv()["Settings"]["HopSettings"]["Enabled"] == false then
			   return false, "Not Enabled"
			end
			if ServiceTable["Players"].LocalPlayer.Backpack then
				local A = {["Backpack"] = ServiceTable["Players"].LocalPlayer.Backpack}
				A["Backpack"].ChildAdded:Connect(function(Item)
					if tostring(Item) == "Lucky Arrow" or tostring(Item) == "Lucky Stone Mask" then
						getgenv()["Settings"]["HopSettings"]["HopFix"] = true
					end
				end)
				wait(30)
				warn("Fixing, Hopping now!")
				getgenv()["Settings"]["HopSettings"]["HopFix"] = true
			end
		end)
		return Success, (Error or "Success LuckyStopper") 
	end,
	["AntiAFK"] = function(...)
 		local Success, Error = pcall(function(...)
			if getgenv()["Settings"]["HopSettings"]["Enabled"] == false then
			   return false, "Not Enabled"
			end
			ServiceTable["Players"].LocalPlayer.Idled:Connect(function(...)
				ServiceTable["VirtualUser"]:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        			wait(1)
        			ServiceTable["VirtualUser"]:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)				
			end)
		end)
		return Success, (Error or "Success AntiAFK")          
        end
}
--
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
		local FS, Success, Reason = pcall(HF)
		if not Success then
			repeat wait() until (getgenv()["Settings"]["HopSettings"]["HopFix"] ~= nil)
			warn("Time Elapsed, Hopping Servers now..")
			if true then
				loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/v1/Hop.lua"))().ServerHop(getgenv()["Settings"]["HopSettings"]["Mode"])
			end
		else
			loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/YBA/v1/Hop.lua"))().ServerHop(getgenv()["Settings"]["HopSettings"]["Mode"])
		end
	end
}
--
ItemSpawn.OnClientInvoke = function(...)
  local Args = {...}
  local Success, Error = pcall(function()
    if Args[1] == "Item_Spawned" then
      local N = Args[2]["Replica"]
      local C = Args[2]["CFrame"]
      local P = Args[2]["CD"]
      if Settings["SpawnLogger"] == true then
         warn(tostring(N), "Spawned! Collecting:", tostring(TableTable["ItemTable"][tostring(N)] == true))
      end
      if Settings["StopAtLucky"] == true then
        if tostring(N) == "Lucky Arrow" or tostring(N) == "Lucky Stone Mask" then
          warn("Found Lucky, Stopped Hopping for 30 seconds!")
          getgenv()["Settings"]["HopSettings"]["Cancel"] = true
            
          local lthr = coroutine.create(ExtraFunctionTable["LuckyStopper"])
          coroutine.resume(lthr)
        end
      end
      if TableTable["ItemTable"][tostring(N)] == true then
        FunctionTable["QueueFunction"](N, C, P)
      end
    end
  end)
  if not Success then
    warn("CInvoke Error:", Error)
  end
  return unpack(Args)
end

task.spawn(function()
   while task.wait() pcall(ExtraFunctionTable['RegisterPlaying']) end
end
