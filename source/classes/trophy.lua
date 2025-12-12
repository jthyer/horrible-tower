local trophy = object:extend()

function trophy:tag()
  self.win = true
end

function trophy:sprite()
  self:spriteSet("trophy")
  self:setMask(0,0,120,120)
end

return trophy