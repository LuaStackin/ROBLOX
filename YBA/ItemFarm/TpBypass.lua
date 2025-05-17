local TPBypass
TPBypass = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...)
     local args = {...}
     if self.Name == "Returner" and args[1] == "idklolbrah2de"  then
         --
         return "  ___XP DE KEY"
     end
     if getnamecallmethod() == 'FireServer' then
         --
         if args[1] == 'SigL' then
             --
             warn('Ban Attempt Prevented - SigL');
             return
         end
         --
     end
     return TPBypass(self, ...)
end))
