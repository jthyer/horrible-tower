-- init.lua
--  Initializing code for all scenes and individual scenes.
--  Good for GUI objects, maintaining state, etc.

local init = {}

function init.load(sceneNumber)
  manager.addObject("player",0,0)
  
  if sceneNumber == 1 then
    
  elseif sceneNumber == 2 then
    
  end
end

-- return default background color
function init.backgroundColor()
  return 0.5, 0, 0
end

-- return default background texture 
function init.backgroundTexture()
  return "bg_stars"
end

return init