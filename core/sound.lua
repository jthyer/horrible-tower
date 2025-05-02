local sound = {}

function sound.play(snd)
  local currentSound = asset.sound[snd]:clone()
  currentSound:play()
end

return sound