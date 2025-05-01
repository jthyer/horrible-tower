--[[
A scene is basically a room from Game Maker. It reads tile and object data
from my Ogmo scene files in the "scene" folder into a big table, then draws
that data on the screen. 

Let's start with just the tiles and bg images.
--]]

local scene = {}
local sceneData = require("core.sceneData")
local sceneNum = 1

local constTimer = 90
local startTimer = constTimer
local startUpdate = true

function scene.getSceneNum()
  return sceneNum
end

function scene.getSceneType()
  return sceneType
end

function scene.load(s,skipIntro)
  if skipIntro == nil and sceneType ~= "title" then
    sceneType = "start"
    startUpdate = true
    startTimer = constTimer
  end
  sceneNum = s
  
  kb.load()
  bg.load(sceneData[sceneNum])
  objectManager.load(sceneData[sceneNum].objectData)
end

function scene.update()
  objectManager.update()
end

function scene.draw()
  bg.draw()
  objectManager.draw()
end

function scene.win()
  sceneType = "next"
  sound.play("sfx_win")
  startTimer = constTimer
end

function scene.restart(skipIntro)
  scene.load(sceneNum,skipIntro)
end

return scene