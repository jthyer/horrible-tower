local wall = object:extend()

function wall:tag()
  self.solid = true  
end

function wall:update()
  -- overwriting the update step because walls never do anything
end

return wall