local jellyfishDeath = object:extend()

function jellyfishDeath:create()
  self.rotation = 0
  self.timer = 0
end

function jellyfishDeath:sprite()
  self:spriteSet("skull")
end

function jellyfishDeath:update()
  self.timer = self.timer + 1
  self.y = self.y + 0.5
  
  if self.timer % 4 == 0 then 
    self.rotation = self.rotation + math.rad(90)
  end
  if self.timer % 3 == 0 then
    self.visible = nil
  else
    self.visible = true
  end  
  
  if self.timer == 50 then
    self:instanceDestroy()
  end
end

return jellyfishDeath