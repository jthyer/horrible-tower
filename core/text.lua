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

function text.draw()

end

return text