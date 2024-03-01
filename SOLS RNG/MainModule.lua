-- [[ #MAIN_MODULE ]]--

local MainModule = {Version = 1}

-- [[ #SERVICES_REQUIRED ]]--

local PathfindingService = game:GetService("PathfindingService")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

-- [[ #MODULE_FUNCTIONS ]] --

MainModule.AntiAFK = function(...)
    local Client = Players.LocalPlayer
    Client.Idled:Connect(function(...)
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    return true, "Success Loaded Anti-AFK"
end

MainModule.SimplePathFind = function(HumanoidRootPart, Humanoid, Object, Settings)
   local Path = PathfindingService:CreatePath({
		['AgentRadius'] = 5;
		['AgentHeight'] = 5;
		['AgentCanJump'] = true;
	})
  
   if (Settings == nil) then
      Settings = {
       ["RetryCount"] = 0,
       ["Timeout"] = 10
      }
   elseif (Settings ~= nil) then
      if (type(Settings) ~= "table") then
          Settings = {
           ["RetryCount"] = 0,
           ["Timeout"] = 10
          }        
      else
         if (Settings["RetryCount"] == nil) then Settings["RetryCount"] = 0 end
         if (Settings["Timeout"] == nil) then Settings["Timeout"] = 10 end
      end
   end
  
   local SuccessAsync, ErrorAsync = pcall(function(...)
       Path:ComputeAsync(HumanoidRootPart.Position, Object.Position)
   end)
   if not SuccessAsync then
      return false, "ComputeAsync Error, Invalid Args?"
   end

   if Path.Status == Enum.PathStatus.NoPath then
      if (Settings["RetryCount"] ~= 0 and Settings["RetryCount"] > 0) then
         for i = 1, Settings["RetryCount"] do
            Path:ComputeAsync(HumanoidRootPart.Position, Object.Position)
            wait(.5)
         end
      end
      if Path.Status == Enum.PathStatus.NoPath then
         return false, "Invalid Path, Is Your Position Reachable?"
      end
   end

   for Index, Waypoint in ipairs(Path:GetWaypoints()) do
      local Complete = false
      local Timeout = false
      local Thread;
      
      if (Settings["Timeout"] ~= 0 and Settings["Timeout"] > 0) then
         Thread = coroutine.create(function(...)
             for i = 1, Settings["Timeout"] do
                if Complete then break; end
                wait(1)
             end
             if not Complete then
                Timeout = true
                Humanoid:MoveTo(HumanoidRootPart.Position)
             end
         end)
         coroutine.resume(Thread)
      end

      Humanoid:MoveTo(Waypoint.Position)
      if Waypoint.Action == Enum.PathWaypointAction.Jump then
         Humanoid.Jump = true
      end
    
      Humanoid.MoveToFinished:Wait()
     
      if Timeout then
         break;
      end

      Complete = true
   end
   return true, "Succesfully Finished Pathing"
end

return MainModule, "Success Loaded Module"
