--[[
SCENE.LUA

A scene is basically a room from Game Maker. It reads tile and object data
from my editor's scene files in the "scene" folder into a big table, then draws
that data on the screen. 
--]]

local scene = {}
local sceneData = require("core.sceneData")
local sceneNum

function scene.getSceneNum()
  return sceneNum
end

function scene.load(s)
  sceneNum = s
  
  kb.load()
  background.load(sceneData[sceneNum])
  manager.load(sceneData[sceneNum].objectData)
  init.load(sceneNum)
end

function scene.update()
  manager.update()
end

function scene.draw()
  background.draw()
  manager.draw()
end

function scene.next()
  sceneNum = sceneNum + 1
  scene.load(sceneNum)
end

function scene.restart()
  scene.load(sceneNum)
end

return scene