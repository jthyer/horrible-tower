local SPEED = 3;
local SPINSPEED = .028 --0.025
local BULLETSPEED = 4

local player = object:extend()

function player:create()
  self.sprite = asset.sprite["spr_player"]
  self.width = 32
  self.height = 32
  self.mask.width = 24
  self.mask.height = 24
  self.mask.x_offset = 4
  self.mask.y_offset = 4

  self.player = true
end

function player:step()  
  self:readMovement()
  self:checkEnemyCollision()
end

function player:readMovement()
  local old_x = self.x
  local old_y = self.y
  local collide 
  
  self.hspeed = 0
  self.vspeed = 0

  -- read keyboard input
  if keyboard.left() then 
    self.hspeed = -SPEED
  elseif keyboard.right() then
    self.hspeed = SPEED
  end
    
  self:moveIfNoSolid()
end

function player:checkEnemyCollision()
  local collide = self:checkCollision("enemy")
  
  if (collide) then
    self:die()
  end
end

function player:die()
  sound.play("sfx_playerDead")
  self:instanceDestroy()
  scene.restart()
end

function player:draw()
  love.graphics.draw(self.sprite,self.x+self.origin_offset,self.y+self.origin_offset,
    self.rotation,self.flip,1,self.origin_offset,self.origin_offset) 
end

return player