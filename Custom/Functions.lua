local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local RC = 0

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

f.SetLog = function(i, s, s2, s3)
   i.ChildAdded:Connect(function(t)
       local timeout = 0
       repeat wait()
            timeout = timeout + 1
       until tostring(t) ~= "Value" or timeout >= 100
       if tostring(t):sub(1,2) ~= s then
          local GS, IS = tostring(t):gsub(s2, "")
          local GT, IT = tostring(t):gsub(s3, "")
          if not table.find(delete_s, GS) and not table.find(delete_t, GT) then 
             RC = RC + 1
             RS = ("(" .. tostring(RC) .. ")")
             print(tostring(t), "+", RS)
          end
       end
   end)
end

f.CheckSum = function(c, t)
   local u = {}
   local v = 0
   local m = 0
   pcall(function(...)
       u = HttpService:JSONDecode(t.Value)
   end)
   for _, c1 in pairs(c) do
      m = m + 1
      if u[tostring(c1):lower()] == nil then
         v = v + 1
      end
   end
   warn(tostring(v) .. "/" .. tostring(m) .. " Valid") 
   for _, c in pairs(c) do
      if u[tostring(c):lower()] == nil then
         return true, c
      end
   end
   return false, " "
end

f.GetInfo_Items = function(...)
   return table_s, table_t
end

f.GetInfo_Deletes = function(...)
   return delete_s, delete_t
end

f.Start = function(n, arg1, arg2)
   settings().Network.IncomingReplicationLag = math.huge
   wait(3)
   for i = 1, 5000 do
      coroutine.resume(coroutine.create(function()
          f.FireRemote(n, arg1, arg2)
      end))
   end
   wait(3)
   settings().Network.IncomingReplicationLag = 0
   return true
end

local GetClient = function(...)
   return Players.LocalPlayer
end

local Chatted = function(Chat)
   if commands[Chat:lower()] ~= nil then
      commands[Chat:lower()]()
   end
end

GetClient().Chatted:Connect(Chatted)
return f, GetClient
