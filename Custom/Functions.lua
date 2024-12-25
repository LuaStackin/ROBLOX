local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local table_s = {}
local table_t = {}

local delete_s = {}
local delete_t = {}

local commands = {}

local FireRemote = function(name, arg1, arg2)
   return ReplicatedStorage[name]:FireServer(arg1, arg2)
end

local SetNames = function(s, t)
   table_s = s
   table_t = t
end

local SetDeletes = function(s, t)
   delete_s = s
   delete_t = t
end

local SetCommand = function(c, f)
   commands[c:lower()] = f
end

local GetInfo_Items = function(...)
   return table_s, table_t
end

local GetInfo_Deletes = function(...)
   return delete_s, delete_t
end

local Chatted = function(Chat)
   if commands[Chat:lower()] ~= nil then
      commands[Chat:lower()]()
   end
end

return SetNames, SetDeletes, SetCommand, GetInfo_Items, GetInfo_Deletes
