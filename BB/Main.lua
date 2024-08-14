--// SETTINGS & FUNCS

_G.Settings = {
 ["SearchMode"] = "Desc",
 ["Custom"] = {},
 ["Specific"] = "Name",
 ["Hook"] = nil,
 ["SE"] = false,
 ["HE"] = false,
}

local AddCustomItem = function(String)
   table.insert(_G.Settings["Custom"], String:lower())
   return true
end

local IsCustomItem = function(String)
   if table.find(_G.Settings["Custom"], tostring(String):lower()) then
      return true
   end 
   return false
end

local SetSpecific = function(String)
   _G.Settings["Specific"] = String:lower()
   return true
end

local SearchMode = function(String)
   if String ~= "Asc" and String ~= "Desc" then
      String = "Desc"
   end
   _G.Settings["SearchMode"] = String
   return true
end

local SpecificMode = function(Boolean)
   if Boolean ~= false and Boolean ~= true then
      Boolean = false
   end
   _G.Settings["SE"] = Boolean
   return true
end

local HopMode = function(Boolean)
   if Boolean ~= false and Boolean ~= true then
      Boolean = false
   end
   _G.Settings["HE"] = Boolean
   return true
end

local SetWebhook = function(String)
   _G.Settings["Hook"] = String
   return true
end

local HopFunction = function(...)
   loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaStackin/ROBLOX/main/BB/ServerHop.lua"))();
   return true
end

local CheckItem = function(Template, BuyButton) 
   local Finisher = false
   local Name = nil
   local Amount = nil 
   local Valid = false

   if Template.Finisher.Visible == true then
      Finisher = true
      Valid = true
   end

   if not Finisher then
      if IsCustomItem(tostring(Template.ItemName.Text)) then
	 Name = Template.ItemName.Text
         Valid = true
      end
   elseif Finisher then
      Name = Template.ItemName.Text
      Valid = true
   end
   Amount = BuyButton.List.Amount.Text

   return {N = Name, A = Amount, F = Finisher, V = Valid}
end

local SendHook = function(Data)
   local Request;
   local Success, Error = pcall(function(...)
       Request = syn.request({
         Url = _G.Settings["Hook"],
         Method = "POST",
         Headers = {["Content-Type"] = "application/json"},
         Body = game:GetService("HttpService"):JSONEncode(Data)
       })
   end)
   return Success, Request
end

local SendNotif = function(Title, Text, Duration)
     game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
       Text = Text,
       Duration = Duration
    })
    return true
end

--// LOADING

repeat wait() until game.IsLoaded
if game.PlaceId ~= 16581637217 then 
   game:GetService("TeleportService"):Teleport(16581637217)
   return;
end

--// SETUP

--[[ MODE & WEBHOOK SETUP ]]--
SearchMode("Desc")
SpecificMode(false)
HopMode(true)
SetWebhook(_G.Webhook)

--[[ SPECIFIC SETUP ]]--
SetSpecific("Dual Nebula")

--[[ CUSTOM SETUP ]]--

AddCustomItem("Laser Twinblade")

--[[ DEBUG/CHECKS ]]--

if _G.Settings["HE"] then
   _G.Settings["SE"] = false
end  

if _G.FoundAlready == true then
   HopFunction();
   return
end

--// MAIN

game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)

local Client = game:GetService("Players").LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")

for _, Inst in pairs(PlayerGui:GetChildren()) do 
   local Success, Error = pcall(function(...)
      if Inst.Name == "TopGui" or tostring(Inst) == "TopGui" then
         if Inst:FindFirstChild("ScrollingFrame") then
            for _, Item in pairs(Inst.ScrollingFrame:GetChildren()) do
               if Item:FindFirstChild("Template") and Item:FindFirstChild("BuyButton") then
                  local Search = CheckItem(Item.Template, Item.BuyButton)
                  if (Search.V) then
                     local Tag = " [UNKNOWN]"
                     if Search.F then
                        Tag = " [FINISHER]"
                     else
                        Tag = " [CUSTOM]"
                     end
                     SendHook({content = string.format("%s has been found, price: %s```%s```", (Search.N .. Tag), Search.A, game.JobId)})
                     local IsSpecificFound = (_G.Settings["SE"] and Search.N:lower():find(_G.Settings["Specific"]))
                     if IsSpecificFound or not _G.Settings["SE"] then
                        if not _G.Settings["HE"] then
                           _G.FoundAlready = true
                        end
                     end
                  end
               end
            end
         end
      end
   end)
   if not Success then
      warn("[CRITICAL]:", tostring(Error))
   end
end

if _G.FoundAlready == false or _G.FoundAlready == nil then
   HopFunction();
   return
end
