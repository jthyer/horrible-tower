--[[
text.lua

Handles text rendering, managing fonts. Will use this for text box borders
and the like down the line.
]]--

local text = {}
local screen = {}
local queue = {}

function text.setFont(index, size)
  local font = love.graphics.newFont(24)--asset.font[index],size,"mono")
  love.graphics.setFont(font)
end

function text.draw(t, x, y)

end

function text.screenLoad(text)
  if screen.canvas then
    table.insert(queue,text)
    return
  end

  screen = {}
  
  screen.text = text
  
  screen.canvas = love.graphics.newCanvas(window.WINDOW_WIDTH,window.WINDOW_HEIGHT)
  love.graphics.setCanvas(screen.canvas)

  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,window.WINDOW_WIDTH,window.WINDOW_HEIGHT) 
  love.graphics.setColor(1,1,1)
  love.graphics.printf(screen.text, 100, 180, window.WINDOW_WIDTH-200,"center")

  love.graphics.setCanvas()
end

function text.screenUpdate()
  if not screen.canvas then
    return false
  end
  
  if keyboard.actionPressed() then
    screen.canvas = nil
    if #queue > 0 then
      text.screenLoad(queue[1])
      table.remove(queue,1)
    end
  end
  
  return true
end

function text.screenDraw()
  if not screen.canvas then
    return
  end
  
  love.graphics.draw(screen.canvas,0,0,0,1,1)
end

return text