--[[
sceneData.lua 

Transforms my ogmo json files into readable lua tables for scene.lua.
This is a three step process: 
* Reading the tile data
* Reading the solid objects (every game has a "wall" class of objects)
* Reading the remaining objects

This code is complex but robust. I've used it for several completed projects.
]]--

local json = require("library.json")

local dim = window.TILE_DIMENSION 
local sceneLoad, loadTiles, loadObjects

function sceneLoad()
  local sceneData = {}
  local dir = "scenes"
  local files = love.filesystem.getDirectoryItems(dir)
  
  local numScenes = 0
  
  for i, file in ipairs(files) do
    if string.sub(file, -5) == '.json' then
      numScenes = numScenes + 1
      table.insert(sceneData,{})
      
      local raw = love.filesystem.read("scenes/"..file)
      local jsonData = json.decode(raw)
  
      sceneData[numScenes].width = jsonData["width"]
      sceneData[numScenes].height = jsonData["height"]  
      sceneData[numScenes].tileWidth = jsonData["width"] / dim
      sceneData[numScenes].tileHeight = jsonData["height"] / dim
  
      loadTiles(numScenes,sceneData,jsonData)
      loadObjects(numScenes,sceneData,jsonData)
    end
  end
  
  return sceneData
end

function loadTiles(scene,sceneData,jsonData)
  sceneData[scene].tileset = jsonData["layers"][3]["tileset"]
  
  sceneData[scene].tileData = {} 
  for i = 1, sceneData[scene].tileHeight do
    local row = {}
    for i2 = 1, sceneData[scene].tileWidth do
      local coord = jsonData["layers"][3]["data"][i2+((i-1)*sceneData[scene].tileWidth)]
      table.insert(row,coord)
    end
    table.insert(sceneData[scene].tileData,row)
  end
end

function loadObjects(scene,sceneData,jsonData)
  sceneData[scene].objectData = {}
  
  -- load solids
  --  The only reason these are a separate layer is that ogmo doesn't
  --  let me click and drag to create many "entities", so I have to 
  --  make these in tile mode if I want to easily draw a bunch of them.
  for i = 1, sceneData[scene].tileHeight do
    local row = {}
    for i2 = 1, sceneData[scene].tileWidth do
      local coord = jsonData["layers"][2]["data"][i2+((i-1)*sceneData[scene].tileWidth)]
      if coord == 0 then
        local object = {}
        object.class = "wall"
        object.x = (i2-1)*dim
        object.y = (i-1)*dim
        table.insert(sceneData[scene].objectData,object)
      end
    end
  end
  
  -- load entity objects
  for key,v in pairs(jsonData["layers"][1]["entities"]) do
    local object = {}
    object.class = v["name"]
    object.x = v["x"]
    object.y = v["y"]
    table.insert(sceneData[scene].objectData,object)
  end
end

return sceneLoad()