local background = {}

local quads = {}
local canvas
local dim = window.TILE_DIMENSION
local tileset
local x, y 
local setCanvas

function background.load(BGDATA)
  tileset = asset.tileset[BGDATA.tileset]
  
  local image_width = tileset:getWidth()
  local image_height = tileset:getHeight()
  
  local rows = image_width / dim
  local cols = image_height / dim
  
  x, y = 0, 0
  
  for i = 0, cols-1 do
    for j = 0, rows-1 do
      table.insert(quads,love.graphics.newQuad(
        j*dim, i*dim, dim, dim, image_width,image_height))
    end
  end 

  setCanvas(BGDATA)
end

function background.draw()
  love.graphics.draw(canvas,0,0)
end
  
function setCanvas(BGDATA)
  local bgAsset = asset.bg["bg_stars"]
  local bgWidth = bgAsset:getWidth()
  local bgHeight = bgAsset:getHeight()
  local canvasWidth = BGDATA.width * 1
  local canvasHeight = BGDATA.height * 1
  local numHor = math.ceil(canvasWidth / bgWidth)
  local numVert = math.ceil(canvasHeight / bgHeight)
    
  background.canvasWidth = canvasWidth
  background.canvasHeight = canvasHeight
  
  -- draw back layer
  canvas = love.graphics.newCanvas(canvasWidth,canvasHeight)
  love.graphics.setCanvas(canvas)
  
  for i=1,numHor do
    for j=1,numVert do
      love.graphics.draw(bgAsset,(i-1)*bgWidth,(j-1)*bgHeight)
    end
  end

  -- draw tiles
  for i,v in ipairs(BGDATA.tileData) do
    for j,v2 in ipairs(v) do
      if v2 ~= -1 then
        love.graphics.draw(tileset,quads[v2+1],(j-1)*dim,(i-1)*dim)
      end
    end
  end 

  love.graphics.setCanvas()
end

return background