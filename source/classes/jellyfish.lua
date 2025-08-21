local jellyfish = object:extend()

local SPEED = 2

function jellyfish:tag()
  self.enemy = true  
end

function jellyfish:create()
  -- move left or right depending on x position for variation  
  self.hspeed = SPEED * (((self.x/16) % 2) * -2 + 1)
end

function jellyfish:sprite()
  self:spriteSet("skull")
  self:setMask(4,4,24,24)
end

function jellyfish:update()
  local collide = self:moveIfNoSolidHorizontal()
  if collide then
    self.hspeed = self.hspeed * -1
  end
end

function jellyfish:die()
  self:instanceDestroy()
end

return jellyfish