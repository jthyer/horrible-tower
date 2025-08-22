local jellyfishMove = require("source.classes.jellyfish"):extend()

local SPEED = 2

function jellyfishMove:create()
  -- move left or right depending on x position for variation  
  self.hspeed = SPEED * (((self.x/16) % 2) * -2 + 1)
end

function jellyfishMove:sprite()
  self:spriteSet("skull")
  self:setMask(4,4,24,24)
end

function jellyfishMove:update()
  local collide = self:moveIfNoEnemySolidHorizontal()
  if collide then
    self.hspeed = self.hspeed * -1
  end
end

return jellyfishMove