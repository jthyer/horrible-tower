local asset = {}
local files = {}

asset.sprite = {}
asset.sound = {}
asset.bg = {}
asset.tileset = {}
asset.font = {}

local function defineSprites()
  local dir = "assets/sprites"
  local files = love.filesystem.getDirectoryItems(dir)
  
  for i, file in ipairs(files) do
    if string.sub(file, -4) == '.png' then
      local index = string.sub(file,1,string.len(file)-4)
      local filePath = dir .. "/" .. file
      asset.sprite[index] = love.graphics.newImage(filePath)
    end
  end
end

local function defineSounds()
  local dir = "assets/sounds"
  local files = love.filesystem.getDirectoryItems(dir)
  
  for i, file in ipairs(files) do
    local index = string.sub(file,1,string.len(file)-4)
    local filePath = dir .. "/" .. file
    local extension = string.sub(file, -4)
    if extension == '.wav' then
      asset.sound[index] = love.audio.newSource(filePath,"static")
    elseif extension == '.ogg' or extension == '.mp3' then
      asset.sound[index] = love.audio.newSource(filePath,"stream")
    end
  end
end

local function defineBackgrounds()
  local dir = "assets/backgrounds"
  local files = love.filesystem.getDirectoryItems(dir)
  
  for i, file in ipairs(files) do
    if string.sub(file, -4) == '.png' then
      local index = string.sub(file,1,string.len(file)-4)
      local filePath = dir .. "/" .. file
      asset.bg[index] = love.graphics.newImage(filePath)
    end
  end
end

local function defineTilesets()
  local dir = "assets/tiles"
  local files = love.filesystem.getDirectoryItems(dir)
  
  for i, file in ipairs(files) do
    if string.sub(file, -4) == '.png' then
      local index = string.sub(file,1,string.len(file)-4)
      local filePath = dir .. "/" .. file
      asset.tileset[index] = love.graphics.newImage(filePath)
      print(filePath)
    end
  end 
end

defineSprites()
defineBackgrounds()
defineSounds()
defineTilesets()

return asset