-- define window information
local gameTitle = "Ken Griffey Jr.'s Horrible Tower"

global = {}
global.WINDOW_WIDTH = 640
global.WINDOW_HEIGHT = 480
global.TILE_DIMENSION = 16
global.current_width = global.WINDOW_WIDTH
global.current_height = global.WINDOW_HEIGHT

-- import core engine
object = require "core.object" 
manager = require "core.manager"
asset = require "core.asset"
scene = require "core.scene"
sound = require "core.sound"
bg = require "core.background"
kb = require "core.keyboard"
util = require "core.util"

-- TO MOVE: font 
local fontPath = "assets/fonts/gunplay.otf"
local fontSize = 32

-- define frame data
local tickPeriod = 1/60
local accumulator = 0.0
local frameCount = 0
local dtCount = 0
local fps = 0
local debug = true
local frameCanvas = love.graphics.newCanvas(global.WINDOW_WIDTH,global.WINDOW_HEIGHT)

function love.load()
  math.randomseed(os.time())
  
  -- window settings
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle(gameTitle)
  love.window.setVSync( 1 )  
  
  -- TO MOVE
  font = love.graphics.newFont(fontPath,fontSize,"mono")
  love.graphics.setFont(font)
  
  scene.load(1)
end

function love.update(dt)
  local delta = dt

  dtCount = dtCount + delta
  accumulator = accumulator + delta
  if accumulator >= tickPeriod then
    scene.update()
    accumulator = accumulator - tickPeriod
    
    frameCount = frameCount + 1

    if frameCount == 60 then
      fps = math.floor(6000/dtCount)/100
      frameCount = 0
      dtCount = 0
    end
  end  
end

function love.draw()
  love.graphics.setCanvas(frameCanvas)
  scene.draw()
  
  if debug then
    love.graphics.printf(fps,10,10, 200, "left")
    love.graphics.printf(manager.getObjectCount(),10,40, 200, "left")
  end
   
  love.graphics.setCanvas()
  
  local frameScale = math.min(
    global.current_width / global.WINDOW_WIDTH,
    global.current_height / global.WINDOW_HEIGHT
  )
  
  local frameX = (global.current_width - (global.WINDOW_WIDTH*frameScale)) / 2
  local frameY = (global.current_height - (global.WINDOW_HEIGHT*frameScale)) / 2
 
  love.graphics.draw(frameCanvas,frameX,frameY,0,frameScale,frameScale)--]]
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
   
   if key == "f" then
     changeFullscreen()
  end
end

function changeFullscreen()  
  local fullscreen = love.window.getFullscreen()
  
  love.window.setFullscreen(not fullscreen)
  if fullscreen then
    global.current_width, global.current_height = global.WINDOW_WIDTH,global.WINDOW_HEIGHT
  else
    global.current_width, global.current_height = love.graphics.getDimensions()
  end
end
