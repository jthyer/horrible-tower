--[[
text.lua

Handles text rendering, managing fonts. Will use this for text box borders
and the like down the line.
]]--

local text = {}

function text.setFont(index, size)
  local font = love.graphics.newFont(asset.font[index],size,"mono")
  love.graphics.setFont(font)
end

function text.draw(t, x, y)
  love.graphics.setColor(0,0,0)
  love.graphics.printf(t, x, y, window.WINDOW_WIDTH,"center")
  love.graphics.setColor(1,1,1)
end

-- screen types:
--  "continue" = pressing action progresses
--  "end" = do nothing
--  "wait" = wait a certain number of frames
function text.screenLoad(text, screenType, waitTime)
  text.screen = {}
  
  text.screen.text = text
  text.screen.type = screenType
  text.screen.wait = waitTime
  
  text.screen.canvas = love.graphics.newCanvas(window.WINDOW_WIDTH,window.WINDOW_HEIGHT)
  love.graphics.setCanvas(text.screen.canvas)

  local r, g, b = init.backgroundColor()
  love.graphics.setColor(r,g,b,1)
  love.graphics.rectangle("fill",0,0,window.WINDOW_WIDTH,window.WINDOW_HEIGHT) 
  love.graphics.setColor(1,1,1,1)
  
  text.draw("text",0,100)

  love.graphics.setCanvas()
end

return text