-- sound.lua
--  My most redundant interace. Just a couple little things I want that Love
--  doesn't pack in with the sound player out of the box.

local sound = {}

function sound.play(snd)
  local currentSound = asset.sound[snd]:clone()
  currentSound:play()
end

return sound