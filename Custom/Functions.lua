local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local f = {}

local table_s = {}
local table_t = {}

local delete_s = {}
local delete_t = {}

local commands = {}

f.FireRemote = function(name, arg1, arg2)
   return ReplicatedStorage[name]:FireServer(arg1, arg2)
end

f.SetNames = function(s, t)
   table_s = s
   table_t = t
end

f.SetDeletes = function(s, t)
   delete_s = s
   delete_t = t
end

f.SetCommand = function(c, f)
   commands[c:lower()] = f
end

f.GetInfo_Items = function(...)
   return table_s, table_t
end

f.GetInfo_Deletes = function(...)
   return delete_s, delete_t
end

local Chatted = function(Chat)
   if commands[Chat:lower()] ~= nil then
      commands[Chat:lower()]()
   end
end

local GetClient = function(...)
   return Players.LocalPlayer
end

GetClient().Chatted:Connect(Chatted)
return f, GetClient
