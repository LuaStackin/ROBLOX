local Client = game.Players.LocalPlayer
local ci = nil
local cinv = nil

local dk = {}; 
local dt = {}; 
local tb = {};

local se = ""
local sec = ""

local st = ""
local stc = ""

local semcmd = ""
local stmcmd = ""
local demcmd = ""

local sprefix = ""
local tprefix = ""

local rarg = ""
local uifunction = nil
local invfunction = nil

local f = function(dks, dts, inf, inv, sei, seci, sti, stci, stcmd, tcmd, dcmd, stmprefix, tgprefix, remarg, uifunc, invfunc)
   -- tables
   dk = dks
   dt = dts
   tb = {dk, dt}
   -- information
   ci = inf
   cinv = inv
   -- other info
   se = sei
   sec = seci
   st = sti
   stc = stci 
   -- extra info
   semcmd = stcmd
   stmcmd = tcmd
   demcmd = dcmd
   -- extra extra info
   sprefix = stmprefix
   tprefix = tgprefix
   rarg = remarg
   -- most info ever
   uifunction = uifunc
   invfunction = invfunc
end

local Chatted = function(Chatted)
   if Chatted:lower() == semcmd then
      for i, v in pairs(Client.Backpack:GetChildren()) do
         if tostring(v) == se or tostring(v) == sec then
            v.Parent = Client.Character
            v:Activate()
            wait()
         end
      end
   end
   if Chatted:lower() == stmcmd then
      for i, v in pairs(Client.Backpack:GetChildren()) do
         if tostring(v) == st or tostring(v) == stc then
            v.Parent = Client.Character
            v:Activate()
            wait()
         end
      end
   end
   if Chatted:lower() == demcmd then
      for i, v in pairs(Inventory:GetChildren()) do
         local GSubK, IndexK = tostring(v):gsub(sprefix, "")
         local GSubT, IndexT = tostring(v):gsub(tprefix, "")
         if table.find(dk, GSubK) or table.find(dt, GSubT) then
            warn(tostring(v), "Deleted!")
            MainEvent:FireServer(remarg, tostring(v))  
            wait(1)
         end
      end
   end
   if Chatted:lower() == "rui" then
      uifunction()
   end
   if Chatted:lower() == "ispace" then
      invfunction()
   end
end

local f1 = function()
   Client.Chatted:Connect(Chatted)
end

return f, f1
