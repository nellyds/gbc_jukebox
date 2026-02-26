title = {}
title.phase = 0
local constants = require('src/constants')
local game_state_manager = require('src/game_state_manager')
title_img = love.graphics.newImage("sprites/ui/title.png")
title.anim_time = 0
title.anim_state = constants.CLOSED
title.inc = 0
local colors = require('assets/colors')

function title:draw()
  if title.phase ==0 then
    love.graphics.print("Made by Neltron3030 in Love2d and Famitracker", 80, 320)
  elseif title.phase ==1 then
            love.graphics.setColor(0,0,255)
        love.graphics.print("Press Space to start", 20, 320)
    love.graphics.setColor(255,255,255)
        love.graphics.draw(title_img, 0, 0)
        love.graphics.setColor(0,0,0)
        love.graphics.print("Press Space to start", 240, 610)
    love.graphics.setColor(255,255,255)
  end
end

function title:update(dt)
  if (title.anim_state == constants.OPENING or title.anim_state == constants.CLOSING) then
  title.anim_time = title.anim_time + 1
  end
  if title.anim_time ==120 then
    title.phase = title.phase +1
    title.anim_time = 0
    title.anim_state = constants.CLOSED
    transitions:add_transition(colors.white, 120, constants.OUT)
  end

if title.phase == 2 then
    game_state_manager:change_state(constants.PL_ACT)
  end
end

function title:handle_keypress(key)
  if key == "space" then
    title.anim_state = constants.OPENING
    transitions:add_transition(colors.white, 120, constants.IN)
  end
  
end

return title