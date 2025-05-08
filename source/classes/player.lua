local player = object:extend()

local SPEED = 3;

function player:sprite()
  self.sprite = asset.sprite["spr_player"] 
  self:setMask(8,8,12,12)
end

function player:tag()
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

return player