local jellyfish = object:extend()

function jellyfish:tag()
  self.enemy = true  
end

function jellyfish:sprite()
  self:spriteSet("skull")
  self:setMask(4,4,24,24)
end

return jellyfish