local player = object:extend()

local SPEED = 3
local JUMP = 6
local GRAVITY = 0.2
local FASTFALL = 10
local SLOWFALL = 5
local TIME_TO_RELEASE = 4

function player:sprite()
  self.sprite = asset.sprite["player"] 
  self:setMask(12,12,8,24)
end

function player:tag()
  self.player = true
end

function player:create()
  self.jumpRelease = false
  self.jumpTimer = 0
  self.maxFallSpeed = FASTFALL
end

function player:step()  
  self:horizontalMovement()
  self:verticalMovement()
  self:checkEnemyCollision()
end

function player:horizontalMovement()
  local old_x = self.x
  local old_y = self.y
  
  self.hspeed = 0

  -- read keyboard input
  if keyboard.left() then 
    self.hspeed = -SPEED
  elseif keyboard.right() then
    self.hspeed = SPEED
  end
    
  self:moveIfNoSolidHorizontal()
end

function player:verticalMovement()
  local grounded = self:checkCollision("solid",0,1)
            
  if grounded then
    if keyboard.actionPressed() then
      self.vspeed = -JUMP
      self.jumpRelease = false
      self.jumpTimer = TIME_TO_RELEASE
    end
  else  
    self.maxFallSpeed = SLOWFALL
    if (not keyboard.action()) or
      (self.jumpRelease and self.vspeed < 0) then 
      self.jumpRelease = true
      if self.jumpTimer > 0 then 
        self.jumpTimer = self.jumpTimer - 1
      else
        if self.vspeed < -GRAVITY then
          self.vspeed = self.vspeed + GRAVITY
        end
        self.maxFallSpeed = FASTFALL
        self.vspeed = self.vspeed + (GRAVITY / 2)
      end
    end
    self.vspeed = self.vspeed + GRAVITY
    if self.vspeed > self.maxFallSpeed then
      self.vspeed = self.maxFallSpeed
    end
  end  
  
  local move = self:moveIfNoSolidVertical()
  if move and (self.y < move.y) then
    self.vspeed = 0
  end
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