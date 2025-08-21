local jellyfishShoot = require("source.classes.jellyfish"):extend()

local SHOTSPEED = 2
local SHOTINTERVAL = 120

function jellyfishShoot:create()
  self.shotTimer = SHOTINTERVAL
end

function jellyfishShoot:sprite()
  self:spriteSet("skull")
  self:setMask(4,4,24,24)
end

function jellyfishShoot:update()
  if self.shotTimer == 0 then
    manager.addObject("jellyfishMove",self.x,self.y)
    self.shotInterval = SHOTINTERVAL
  end
  
  self.shotTimer = self.shotTimer - 1
end

return jellyfishShoot