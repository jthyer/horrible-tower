--[[
Objects are defined on a scene by scene basis. The object table is completely
emptied between scenes. 

All the implementation for the basic game world object is done in object.lua.
Specific object implementations are done in the source folder on a per-game
basis. The intent here is to mimic the basic functionality of a blank object
in Game Maker.
--]]

local manager = {}
local objectTable = {}
local objectToDestroy = {}
local instanceID 

local Class = {}

local function defineClasses()
  local dir = "source/classes"
  local files = love.filesystem.getDirectoryItems(dir)
  
  for i, file in ipairs(files) do
    if string.sub(file, -4) == '.lua' then
      local className = string.sub(file,1,string.len(file)-4)
      Class[className] = require("source.classes." .. className)
    end
  end
end

defineClasses()

function manager.addObject(classIndex,x,y)
  local obj = Class[classIndex](instanceID,x,y)
  table.insert(objectTable,obj)
  
  instanceID = instanceID + 1
    
  return obj
end

function manager.removeObject(id)
  table.insert(objectToDestroy,id)
end

function manager.getObject(id)
  for i,obj in ipairs(objectTable) do
    if obj.id == id then
      return obj
    end
  end
  
  return nil
end

function manager.getObjectByTag(tag)
  for i,obj in ipairs(objectTable) do
    if obj[tag] then
      return obj
    end
  end
  
  return nil
end

function manager.checkObjects(f,arg)
  -- perform a passed function on all objects 
  -- immediately return true if any f(obj) returns true
  for i,obj in ipairs(objectTable) do
    if f(obj,arg) then
      return obj
    end
  end
  return nil
end  

function manager.load(OBJECTDATA)
  objectTable = {}
  objectToDestroy = {}
  instanceID = 1
    
  for i,obj in ipairs(OBJECTDATA) do
    if obj.class == "skull" then
      hostileTotal = hostileTotal + 1
    end
    manager.addObject(obj.class,obj.x,obj.y)
  end
end

function manager.update()
  for i,obj in ipairs(objectTable) do
    obj:update()
  end 

  -- destroy all objects marked for death
  for i,id in ipairs(objectToDestroy) do
    for k,obj in ipairs(objectTable) do
      if obj.id == id then
        if obj.skull then
          hostileKills = hostileKills + 1
          if hostileKills == hostileTotal then
            scene.win() 
          end
        end
        table.remove(objectTable,k)
        break
      end
    end 
  end 
  objectToDestroy = {}
end

function manager.draw()
  for i,obj in ipairs(objectTable) do
    obj:draw()
  end 
end

function manager.getClass(str)
  return Class[str]
end

function manager.getObjectCount()
  return #objectTable
end

return manager