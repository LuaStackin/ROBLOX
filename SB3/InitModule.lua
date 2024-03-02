-- [[ #INIT_MODULE ]]--

local Init = {Version = 1}

-- [[ #SERVICES_REQUIRED ]]--

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--[[ #LOCAL_VARIABLES ]]--

local ResetTime, Thread = nil,nil

-- [[ #MODULE_BODY ]]--

local Source = "https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/SB3/MainModule.lua"
local HttpSuccess, HttpReturn = pcall(game.HttpGet, game, Source)

-- [[ #MODULE_LOADING ]]--

local LoadSuccess, Module = loadstring(HttpReturn)()
 
-- [[ #MODULE_FUNCTIONS ]]--

local CheckTag, AddTag, ClearTags = Module.CheckTag, Module.AddTag, Module.ClearTags
local UpdateGlobal, AddItem = Module.UpdateGlobalSettings, Module.AddItem
local ItemData, ValidatePurchase = Module.ReturnItemData, Module.ValidatePurchase

--[[ #MAIN_SCRIPT ]]--

local Function = function(PurchaseCallback, Settings)
    Module.ClearTags("ItemLogged")
    Module.ClearTags("PurchaseCallback")
    if Settings["MininumPlayerCount"] ~= nil then
       if (Settings["MininumPlayerCount"] > #Players:GetPlayers()) then
          Module.ServerHop()
       end
    end
    for i, v in pairs(Module.ReturnCurrentDrops()) do
        local Data = ItemData(v)
        local ValidPurchase, Message = ValidatePurchase(Data)
        local Purchased = false
        if ValidPurchase then
            Module.PurchaseItem(v)
            if not CheckTag(v, "PurchaseCallback") then
               AddTag(v, "PurchaseCallback")
               pcall(PurchaseCallback, Data)
            end
            Purchased = true
        end
        if Purchased then
	    if ResetTime ~= nil then
               local TimeR = ResetTime()
	       print("Item Found, Time Reset To:", tostring(TimeR))
	    end
            if not CheckTag(v, "ItemLogged") then
               AddTag(v, "ItemLogged")
	       print(Data.Name, Data.Owner, ValidPurchase, Message)
            end
        else
            if not CheckTag(v, "ItemLogged") then
               AddTag(v, "ItemLogged")
	       warn(Data.Name, Data.Owner, ValidPurchase, Message)
            end
        end
    end
end

-- [[ #SETUP_FUNCTION ]]--

Init.Setup = function(Settings, Callback)
   local Method = nil
   local ServerHopSettings = nil
   if Settings == nil then
      Settings = {["Method"] = "RunService"}
   else
      if Settings["ServerHopTimer"] ~= nil and Settings["ServerHopTimer"] ~= 0 then
         ResetTime, Thread = Module.CreateTimer((60 * Settings["ServerHopTimer"]), Module.ServerHop)	 
      end
      if Settings["Method"] ~= nil then
         Method =  Settings["Method"]
      end
   end
   if Method ~= "While" and Method ~= "RunService" then
      Method = "RunService"
   end
   if Callback == nil then
      Callback = function(ItemData)
         return 
      end
   end
   if Callback ~= nil then
      if type(Callback) ~= "function" then
         Callback = function(ItemData)
            return
         end
      end
   end
   if Method == "RunService" then
      local Connection;
      Connection = RunService.RenderStepped:Connect(function(...)
          Function(Callback, Settings)
      end)
      return Connection
   elseif Method == "While" then
      local Kill = false
      local KillSwitch = function(...)
         Kill = true 
      end
      local Subroutine = coroutine.create(function(...)
          while true do
             local Success, Error = pcall(Function, Callback, Settings)
             if not Success then
                warn("Error -", tostring(Error))
             end
             if Kill then
                warn("Killing While Loop!")
                break;
             end
             wait()
          end
      end)
      coroutine.resume(Subroutine)
      return KillSwitch
   end
end

-- [[ #INIT ]]--

return Init, UpdateGlobal, AddItem, Module
