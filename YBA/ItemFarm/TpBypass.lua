local TPBypass
TPBypass = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...)
     local args = {...}
     if self.Name == "Returner" and args[1] == "idklolbrah2de"  then
         return "  ___XP DE KEY"
     end
     return TPBypass(self, ...)
end))
