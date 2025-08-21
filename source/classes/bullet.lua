local bullet = object:extend()

local SPEED = 5

function bullet:tag()
  self.enemy = true 
  self.spike = true
end

function bullet:sprite()
  self:spriteSet("spike")
  self:setMask(2,2,12,12)
end

function bullet:create()
  local player = manager.getObjectByTag("player")
  local target_x, target_y = player.x + 8, player.y + 8
 
  self:setVectorAimed(target_x,target_y,SPEED,true)
end

function bullet:update()
  self:move()
end

return bullet