--[[
init.lua

Initializing code for all scenes and individual scenes.
Good for GUI objects, maintaining state, etc.
]]--

local init = {}
local textSeen = 0

function init.load(sceneNumber)
  if sceneNumber == 1 and textSeen == 0 then
    text.screenLoad("Ken Griffey Jr.'s Horrible Tower\n\nPress Z to Start")
    text.screenLoad("\"You are just a pathetic little kitty.\"")
    text.screenLoad("\"You will never escape my tower.\"")
    textSeen = 1
  elseif sceneNumber == 2 and textSeen == 1 then
    text.screenLoad("\"In 1993, I scored home runs in eight games in a row.\"")
    text.screenLoad("\"Ascending all six floors of my tower is an even more impossible task.\"")
    textSeen = 2
  elseif sceneNumber == 3 and textSeen == 2 then
    background.setTexture("bg_dawn")
    text.screenLoad("\"Give up now.\"")
    text.screenLoad("\"You can’t get past my jellyfish armada.\"")
    textSeen = 3
  elseif sceneNumber == 4 and textSeen == 3 then
    text.screenLoad("\"You’re a real MVP...\"")
    text.screenLoad("\"...Most Vigorously Pitiful!!\"")
    textSeen = 4
  elseif sceneNumber == 5 and textSeen == 4 then
    background.setTexture("bg_dusk")
    text.screenLoad("\"You’ll strike out on this floor for sure.\"")
    textSeen = 5
  elseif sceneNumber == 6 and textSeen == 5 then
    text.screenLoad("\"Just quit!\"")
    text.screenLoad("\"If even I couldn’t make it to the world series in all my years of play...\"")
    text.screenLoad("\"...there’s no way you’ll be able to defeat my elite jellyfish captain.\"")
    textSeen = 6
  elseif sceneNumber == 7 and textSeen == 6 then
    background.setTexture("bg_sky")
    text.screenLoad("\"I can’t believe you escaped my tower.\"")
    text.screenLoad("\"You are truly a hall of fame player.\"")
    textSeen = 7
  elseif sceneNumber == 8 and textSeen == 7 then
    text.screenLoad("You have defeated Ken Griffey Jr. and his horrible tower.")
    text.screenLoad("But beware...")
    text.screenLoad("As long as there is darkness in the hearts of man...")
    text.screenLoad("Ken Griffey Jr. will live on...")
    text.screenLoad("The End\n\nPress R to Restart\nPress Esc to Quit")
  end
end

-- return default background color
function init.backgroundColor()
  return 0, 0, 0
end

-- return default background texture 
function init.backgroundTexture()
  return "bg_night"
end

return init