--[[
object.lua

Base definition of an object, in the Game Maker sense. An object exists
within a scene, and is completely destroyed whenever a scene is restarted
or reloaded. 

An object at its most simple is just an x and y coordinate, a hitbox, and
a class file that defines its behavior. If an object has a sprite, that sprite
is drawn at the x and y coordinate of the object every frame. An object can 
have "tags", like "solid" or "enemy" that other objects can check against.
Most objects will have step events, which run every frame.

Collision code is all handled here, including collision pertaining to solid 
objects. This is very important for making platformers, among other games.

Sprite animation will be handled here automatically, without the game-specific
code needing to worry about it.

I'll build out many other behaviors in here as needed for different games.

TODO:
- Refactor out hspeed and vspeed as default values. Let the movement code
  handle that, since its complicated.
- Fix instanceCreate, rename to remove "instance" gml terminology.
]]--

local objectParent = require "library.classic"
local object = objectParent:extend()

-- object constructor
-- runs sprite, tag, create constructors as needed
function object:new(id, class, x, y)
  self.id = id
  self.class = class
  self.x = x
  self.y = y
  self.hspeed = 0
  self.vspeed = 0
  
  if self.sprite then 
    self:sprite()
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
  else
    self.width = 16
    self.height = 16
  end

  if self.mask == nil then
    self:setMask(self.width,self.height,0,0)
  end
  
  if self.tag then 
    self:tag() 
  end
  
  if self.create then 
    self:create() 
  end
end

function object:update()
  if self.step then 
    self:step() 
  end
  
  -- updating sprite animation, if self.sprite then
end

function object:draw()
  if self.sprite ~= nil then
     love.graphics.draw(self.sprite,self.x,self.y,0,1,1) 
  end
end

function object:setMask(w,h,x,y)
  self.mask = {}
  self.mask.x = x
  self.mask.y = y
  self.mask.width = w
  self.mask.height = h
end

-- basic movement function for objects with no solid detection
function object:move()
  self.x = self.x + self.hspeed
  self.y = self.y + self.vspeed
end

-- basic collision function, returns true if colliding with object with given tag
function object:checkCollision(tag)
  local function f(obj,tag)
    local collision = false
    
    local x, y = self.x + self.mask.x, self.y + self.mask.y
    local h, w = self.mask.height, self.mask.width
    local x2, y2 = obj.x + obj.mask.x, obj.y + obj.mask.y
    local h2, w2 = obj.mask.height, obj.mask.width    
    
    if (tag == nil or obj[tag] ~= nil) and (self.id ~= obj.id) then
      if (util.checkOverlap(x,y,w,h,x2,y2,w2,h2)) then
        collision = true
      end
    end
    
    return collision
  end
      
  return manager.checkObjects(f,tag)
end

-- functions for moving around solid objects
function object:moveIfNoSolid()
  local old_x, old_y = self.x, self.y
  
  self.x = self.x + self.hspeed
  
  local collide = self:checkCollision("solid")
  if (collide) then
    self.x = old_x
    self:moveToContactHor(collide)
  end
  
  self.y = self.y + self.vspeed
  
  collide = self:checkCollision("solid")
  if (collide) then
    self.y = old_y
    self:moveToContactVert(collide)
  end  
end

-- snap against side of given object horizontally
function object:moveToContactHor(obj)
  local pushback
  
  local x = self.x + self.mask.x
  local x2 = obj.x + obj.mask.x
  local w = self.mask.width
  local w2 = obj.mask.width
  
  if x < x2 then
    pushback = x + w - x2
    self.x = self.x - pushback
  elseif x2 < x then
    pushback = x2 + w2 - x
    self.x = self.x + pushback
  end
end

-- snap against side of given object horizontally
function object:moveToContactVert(obj)
  local pushback
  
  local y = self.y + self.mask.y
  local y2 = obj.y + obj.mask.y
  local h = self.mask.height
  local h2 = obj.mask.height
  
  if y < y2 then
    pushback = y + h - y2
    self.y = self.y - pushback
  elseif y2 < y then
    pushback = y2 + h2 - y
    self.y = self.y + pushback
  end
end

function object:instanceCreate(class,x,y)
  -- TO FIX 
  -- If an object calls this function in its creation code, they'll both have
  -- the same instance ID. Make a queue of objects to create and create them at the end.
  -- Make sure THOSE objects can create objects.
  
  return manager.addObject(class,x,y)
end

-- can target another ID, or the object can destroy itself
function object:instanceDestroy(targetID)
  local id = targetID or self.id

  return manager.removeObject(id)
end

return object