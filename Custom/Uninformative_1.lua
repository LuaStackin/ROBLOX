
local arg1p = nil
local arg2p = nil

local f = function(a, b)
   arg1p = a
   arg2p = b
end

local f1 = function(arg1, arg2)
   local a = {}
   local c = ""
   pcall(function(...)
	     a = game:GetService("HttpService"):JSONDecode(arg2.Value)
   end)
   for _, b in pairs(arg1) do
      if a[tostring(b):lower()] == nil then
         c = b
      end
   end
   if c == "" then
      return false, c
   else
      return true, c
   end
end

local f2 = function(arg1)
   settings().Network.IncomingReplicationLag = Input
end

local f3 = function(arg1, arg2)
   local arg3s, arg3 = f1(arg1p, arg2p)
   if (not arg3s or arg3 == "") then
      warn("[ERR, ARG3]")
      return false
   end
   f2(math.huge)
   wait(3)
   local arg3 = f1(arg1p, arg2p)
   for i = 1, FireAmount do
      arg1:FireServer(arg2, arg3)
   end
   wait(3)
   f2(0)
   return true
end

return f3
