local DefaultSettings = {
	["\72\111\112\83\101\116\116\105\110\103\115"] = {
		["\69\110\97\98\108\101\100"] = false,
		["\72\111\112\84\105\109\101\114"] = 20,
		["\67\97\110\99\101\108"] = false
	},
	["\67\97\108\108\98\97\99\107"] = function(Item)
		warn(Item, "\67\111\108\108\101\99\116\101\100\33")
	end,
	["\73\116\101\109\115"] = {
	 ["\68\101\102\97\117\108\116"] = true
	},
	["\83\112\97\119\110\76\111\103\103\101\114"] = true,
	["\83\116\111\112\65\116\76\117\99\107\121"] = true
}

if getgenv()["\83\101\116\116\105\110\103\115"] == nil then
	getgenv()["\83\101\116\116\105\110\103\115"] = DefaultSettings
elseif getgenv()["\83\101\116\116\105\110\103\115"] ~= nil then
	for i, v in pairs(getgenv()["\83\101\116\116\105\110\103\115"]) do
		if DefaultSettings[i] ~= nil then
			if type(v) == "\116\97\98\108\101" then
				for z, x in pairs(DefaultSettings[i]) do
					if getgenv()["\83\101\116\116\105\110\103\115"][i][z] == nil then
						getgenv()["\83\101\116\116\105\110\103\115"][i][z] = x
						warn(z, "\119\97\115\32\109\105\115\115\105\110\103\32\102\114\111\109", i, "\115\111\32\105\116\32\119\97\115\32\114\101\112\108\97\99\101\100\32\119\105\116\104\32\116\104\101\32\100\101\102\97\117\108\116\32\118\97\108\117\101\32\111\102", x)
					end
				end
			else
				for z, x in pairs(DefaultSettings) do
					if getgenv()["\83\101\116\116\105\110\103\115"][z] == nil then
						getgenv()["\83\101\116\116\105\110\103\115"][z] = x
						warn(i, "\119\97\115\32\109\105\115\115\105\110\103\32\115\111\32\105\116\32\119\97\115\32\114\101\112\108\97\99\101\100\32\119\105\116\104\32\116\104\101\32\100\101\102\97\117\108\116\32\118\97\108\117\101\32\111\102", x)
					end
				end
			end
		end
	end
end

local Hook
local ServiceTable = {
	["\80\108\97\121\101\114\115"] = game:GetService("\80\108\97\121\101\114\115"),
	["\82\117\110\83\101\114\118\105\99\101"] = game:GetService("\82\117\110\83\101\114\118\105\99\101")
}

local TableTable = {
	["\81\117\101\117\101\84\97\98\108\101"] = {},
	["\73\116\101\109\84\97\98\108\101"] = {
		["\76\117\99\107\121\32\65\114\114\111\119"] = true,
		["\76\117\99\107\121\32\83\116\111\110\101\32\77\97\115\107"] = true,
		["\77\121\115\116\101\114\105\111\117\115\32\65\114\114\111\119"] = false,
		["\82\111\107\97\107\97\107\97"] = false,
		["\82\105\98\32\67\97\103\101\32\111\102\32\84\104\101\32\83\97\105\110\116\39\115\32\67\111\114\112\115\101"] = false,
		["\90\101\112\101\108\108\105\110\39\115\32\72\101\97\100\98\97\110\100"] = false,
		["\81\117\105\110\116\111\110\39\115\32\71\108\111\118\101"] = false,
		["\80\117\114\101\32\82\111\107\97\107\97\107\97"] = false,
		["\83\116\101\101\108\32\66\97\108\108"] = false,
		["\83\116\111\110\101\32\77\97\115\107"] = false,
		["\65\110\99\105\101\110\116\32\83\99\114\111\108\108"] = false,
		["\68\105\111\39\115\32\68\105\97\114\121"] = false, 
		["\68\105\97\109\111\110\100"] = false,
		["\71\111\108\100\32\67\111\105\110"] = false
	}
}

local ExtraFunctionTable = {
	["\84\101\108\101\112\111\114\116"] = function(C)
		local Success, Error = pcall(function(...)
			if ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Character then
				local A = {["\67\104\97\114\97\99\116\101\114"] = ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Character}
				if A["\67\104\97\114\97\99\116\101\114"]:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116") then
					A["\67\104\97\114\97\99\116\101\114"]["\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116"].CFrame = C
				end
			end
		end)
		return Success, (Error or "\83\117\99\99\101\115\115")
	end,
	["\82\101\103\105\115\116\101\114\80\108\97\121\105\110\103"] = function(...)
		local Success, Error = pcall(function(...)
			if ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Character then
				local A = {["\67\104\97\114\97\99\116\101\114"] = ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Character, ["\80\108\97\121\101\114\71\117\105"] = ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.PlayerGui}
				if A["\67\104\97\114\97\99\116\101\114"]:FindFirstChild("\82\101\109\111\116\101\69\118\101\110\116") and A["\80\108\97\121\101\114\71\117\105"]:FindFirstChild("\76\111\97\100\105\110\103\83\99\114\101\101\110") then
					A["\67\104\97\114\97\99\116\101\114"]["\82\101\109\111\116\101\69\118\101\110\116"]:FireServer("\80\114\101\115\115\101\100\80\108\97\121")
					repeat wait() until not A["\80\108\97\121\101\114\71\117\105"]:FindFirstChild("\76\111\97\100\105\110\103\83\99\114\101\101\110\49")
					loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\76\117\97\83\116\97\99\107\105\110\47\82\79\66\76\79\88\47\109\97\105\110\47\89\66\65\47\73\116\101\109\70\97\114\109\47\65\117\116\111\77\101\110\117\46\108\117\97"))()
				end
			end
		end)
		return Success, (Error or "\83\117\99\99\101\115\115") 
	end,
	["\76\117\99\107\121\83\116\111\112\112\101\114"] = function(...)
		local Success, Error = pcall(function(...)
			if getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]["\69\110\97\98\108\101\100"] == false then
			   return false, "\78\111\116\32\69\110\97\98\108\101\100"
			end
			if ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Backpack then
				local A = {["\66\97\99\107\112\97\99\107"] = ServiceTable["\80\108\97\121\101\114\115"].LocalPlayer.Backpack}
				A["\66\97\99\107\112\97\99\107"].ChildAdded:Connect(function(Item)
					if tostring(Item) == "\76\117\99\107\121\32\65\114\114\111\119" or tostring(Item) == "\76\117\99\107\121\32\83\116\111\110\101\32\77\97\115\107" then
						getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]["\72\111\112\70\105\120"] = true
					end
				end)
				wait(30)
				warn("\70\105\120\105\110\103\44\32\72\111\112\112\105\110\103\32\110\111\119\33")
				getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]["\72\111\112\70\105\120"] = true
			end
		end)
		return Success, (Error or "\83\117\99\99\101\115\115") 
	end
}

local FunctionTable = {
	["\81\117\101\117\101\70\117\110\99\116\105\111\110"] = function(N, C, P)
		table.insert(TableTable["\81\117\101\117\101\84\97\98\108\101"], {N = N, C = C, P = P})
	end,
	["\83\101\97\114\99\104\70\117\110\99\116\105\111\110"] = function(Callback)
		for i, v in pairs(TableTable["\81\117\101\117\101\84\97\98\108\101"]) do
			ExtraFunctionTable["\84\101\108\101\112\111\114\116"](v.C) 
			wait(v.P.HoldDuration + 0.1)
			if v.P:FindFirstChild("\82\101\109\111\116\101\69\118\101\110\116") then
				local Event = v.P:FindFirstChild("\82\101\109\111\116\101\69\118\101\110\116")
				Event:FireServer()
				wait(1.5)
				if Callback ~= nil then
					Callback(v.N)
				end 
				table.remove(TableTable["\81\117\101\117\101\84\97\98\108\101"], i)
			else
				table.remove(TableTable["\81\117\101\117\101\84\97\98\108\101"], i)
				break
			end
		end
	end,
	["\84\101\108\101\112\111\114\116\66\121\112\97\115\115"] = function(self, ...)
		local Args = {...}
		if tostring(self) == "\82\101\116\117\114\110\101\114" and Args[1] == "\105\100\107\108\111\108\98\114\97\104\50\100\101" then
			warn("\46\46\46")
			return "\32\32\95\95\95\88\80\32\68\69\32\75\69\89"
		end
		return Hook(self, ...)
	end,
	["\72\111\112\70\117\110\99\116\105\111\110"] = function(...)
		local A = getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]
		if A["\69\110\97\98\108\101\100"] then
			wait(A["\72\111\112\84\105\109\101\114"]) 
			if not A["\67\97\110\99\101\108"] then
				return true, "\72\111\112\112\105\110\103\32\83\101\114\118\101\114\115"
			else
				return false, "\83\101\114\118\101\114\32\72\111\112\32\83\116\111\112\112\101\100"
			end
		end
	end,
	["\72\111\112\67\111\110\116\114\111\108"] = function(HF)
		local FS, Success, Reason = pcall(HF)
		if not Success then
			repeat wait() until (getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]["\72\111\112\70\105\120"] ~= nil)
			warn("\84\105\109\101\32\69\108\97\112\115\101\100\44\32\72\111\112\112\105\110\103\32\83\101\114\118\101\114\115\32\110\111\119\46\46")
			if true then
				loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\76\117\97\83\116\97\99\107\105\110\47\82\79\66\76\79\88\47\109\97\105\110\47\89\66\65\47\118\49\47\72\111\112\46\108\117\97"))().ServerHop()
			end
		else
			loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\76\117\97\83\116\97\99\107\105\110\47\82\79\66\76\79\88\47\109\97\105\110\47\89\66\65\47\118\49\47\72\111\112\46\108\117\97"))().ServerHop()
		end
	end
}

local ITable = {
	["\73\116\101\109\83\112\97\119\110\101\114"] = game:GetService("\82\101\112\108\105\99\97\116\101\100\83\116\111\114\97\103\101"):WaitForChild("\73\116\101\109\83\112\97\119\110"),
	["\73\116\101\109\70\117\110\99\116\105\111\110"] = function(...)
		local Args = {...}
		local Success, Error = pcall(function()
			if Args[1] == "\73\116\101\109\95\83\112\97\119\110\101\100" then
				local N = Args[2]["\82\101\112\108\105\99\97"]
				local C = Args[2]["\67\70\114\97\109\101"]
				local P = Args[2]["\67\68"]
				if Settings["\83\112\97\119\110\76\111\103\103\101\114"] == true then
					warn(N, "\83\112\97\119\110\101\100\33\32\67\111\108\108\101\99\116\105\110\103\58", tostring(TableTable["\73\116\101\109\84\97\98\108\101"][tostring(N)] == true))
				end
				if Settings["\83\116\111\112\65\116\76\117\99\107\121"] == true then
					if tostring(N) == "\76\117\99\107\121\32\65\114\114\111\119" or tostring(N) == "\76\117\99\107\121\32\83\116\111\110\101\32\77\97\115\107" or tostring(N) == "\82\111\107\97\107\97\107\97" then
						warn("\70\111\117\110\100\32\76\117\99\107\121\44\32\83\116\111\112\112\101\100\32\72\111\112\112\105\110\103\32\102\111\114\32\51\48\32\115\101\99\111\110\100\115\33")
						getgenv()["\83\101\116\116\105\110\103\115"]["\72\111\112\83\101\116\116\105\110\103\115"]["\67\97\110\99\101\108"] = true
						ExtraFunctionTable["\76\117\99\107\121\83\116\111\112\112\101\114"]()
					end
				end
				if TableTable["\73\116\101\109\84\97\98\108\101"][tostring(N)] == true then
					FunctionTable["\81\117\101\117\101\70\117\110\99\116\105\111\110"](N, C, P)
				end
			end
		end)
		if not Success then
			warn("\67\73\110\118\111\107\101\32\69\114\114\111\114\58", Error)
		end
		return unpack(Args)
	end
}

if getgenv()["\83\101\116\116\105\110\103\115"]["\73\116\101\109\115"]["\68\101\102\97\117\108\116"] == false then
	for item, value in pairs(getgenv()["\83\101\116\116\105\110\103\115"]["\73\116\101\109\115"]) do
		if value ~= false and value ~= true then
			value = true
		end
		TableTable["\73\116\101\109\84\97\98\108\101"][item] = value
	end
	local NotCollected = {}
	local Collecting = {}
	for i, v in pairs(TableTable["\73\116\101\109\84\97\98\108\101"]) do
		if v == false then
			table.insert(NotCollected, tostring(i))
		elseif v == true then
			table.insert(Collecting, tostring(i))
		end
	end
	warn("\92\110\84\104\101\32\102\111\108\108\111\119\105\110\103\32\105\116\101\109\115\32\97\114\101\32\110\111\116\32\98\101\105\110\103\32\99\111\108\108\101\99\116\101\100\58\92\110" .. table.concat(NotCollected, "\92\110"))
	warn("")
	warn("\92\110\67\111\108\108\101\99\116\105\110\103\32\116\104\101\115\101\32\105\116\101\109\115\58\92\110" .. table.concat(Collecting, "\92\110"))
else
	warn("\73\116\101\109\32\68\101\102\97\117\108\116\39\115\32\83\101\116")
end

Hook = hookmetamethod(game, "\95\95\110\97\109\101\99\97\108\108", FunctionTable["\84\101\108\101\112\111\114\116\66\121\112\97\115\115"])
ITable["\73\116\101\109\83\112\97\119\110\101\114"].OnClientInvoke = ITable["\73\116\101\109\70\117\110\99\116\105\111\110"]

Thread = coroutine.create(FunctionTable["\72\111\112\67\111\110\116\114\111\108"])
coroutine.resume(Thread, FunctionTable["\72\111\112\70\117\110\99\116\105\111\110"])

RSuccess, RError = ExtraFunctionTable["\82\101\103\105\115\116\101\114\80\108\97\121\105\110\103"]()
if not RSuccess then
	warn("\80\82\101\103\105\115\116\101\114\32\69\114\114\111\114\58", RError)
else
	warn("\80\82\101\103\105\115\116\101\114\32\83\117\99\99\101\115\115\33")
end

while true do
	local SFSuccess, SFError = pcall(FunctionTable["\83\101\97\114\99\104\70\117\110\99\116\105\111\110"], function(Name)
		warn(Name)
	end)
	if not SFSuccess then
		warn("\81\83\121\115\116\101\109\32\69\114\114\111\114\58", SFError)
	end
	wait(.5)
end
