-- scene.lua
--  A scene is basically a room from Game Maker. It reads tile and object data
--  from my editor's scene files in the "scene" folder into a big table, loads
--  the background and object managers, runs the manager update function, and
--  draws everything to the screen. 
--]]

local scene = {}
local sceneData = require("core.sceneData")
local sceneNumber
local sceneTotal = #sceneData

function scene.load(i)
  sceneNumber = i
  
  keyboard.load()
  background.load(sceneData[sceneNumber])
  manager.load(sceneData[sceneNumber].objectData)
  init.load(sceneNumber)
end

function scene.update()
  manager.update()
end

function scene.draw()
  background.draw()
  manager.draw()
end

-- TODO: track scenes with indexes for non-linear traversal
function scene.getSceneNumber()
  return sceneNumber
end

function scene.next()
  if sceneNumber < sceneTotal then
    sceneNumber = sceneNumber + 1
  end
  
  scene.load(sceneNumber)
end

function scene.previous()
  if sceneNumber > 1 then
    sceneNumber = sceneNumber - 1
  end
  
  scene.load(sceneNumber)
end

function scene.restart()
  scene.load(sceneNumber)
end

return scene