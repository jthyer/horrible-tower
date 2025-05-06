-- sound.lua
--  My most redundant interace. Just a couple little things I want that Love
--  doesn't pack in with the sound player out of the box.

local sound = {}

local music 

function sound.play(index)
  local currentSound = asset.sound[index]:clone()
  currentSound:play()
end

function sound.musicPlay(index)
  if music ~= nil then
    sound.musicStop()
  end
  
  music = asset.sound[index]
  music:setLooping(true)
  music:play()
end

function sound.musicStop()
  music:stop()
  music = nil
end

return sound