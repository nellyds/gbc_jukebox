title = {}
title.phase = 0
local constants = require('src/constants')
local game_state_manager = require('src/game_state_manager')
title_img = love.graphics.newImage("sprites/ui/title.png")
title.anim_time = 0
title.anim_state = constants.CLOSED
title.inc = 0
function title:enter()
  print("Entering title screen")
end

function title:draw()
  if title.phase ==0 then
    love.graphics.print("Made by Neltron3030 in Love2d and Famitracker", 200, 200)
  elseif title.phase ==1 then
    love.graphics.draw(title_img, 0, 0)
  end
  draw_transition()
end

function draw_transition()
  if title.anim_state == constants.OPENING or title.anim_state == constants.CLOSING  then
    title.anim_time = title.anim_time +1
  end   
  if (title.anim_time == 240) then
    if title.anim_state == constants.OPENING then
      title.phase = title.phase + 1
      title.anim_state = constants.CLOSING
    elseif title.anim_state == constants.CLOSING then
      title.anim_state = constants.CLOSED
    end
    title.anim_time = 0
  end
  local center = love.graphics.getWidth() / 2
  local height = love.graphics.getHeight() / 2
  if title.anim_state == constants.OPENING then
    love.graphics.rectangle("fill", 
    center-(title.anim_time/240)*center,
    height-(title.anim_time/240)*height,
    love.graphics.getWidth()*(title.anim_time/240),
    love.graphics.getHeight()*(title.anim_time/240))
  elseif title.anim_state ==constants.CLOSING then
    if (title.anim_time % 24 == 0) then
      title.inc = title.inc + (24/240)
    end
    love.graphics.setBlendMode("add")
    love.graphics.setColor(255,255,255,
1-title.inc
  )
    
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255,255,255)
    love.graphics.setBlendMode("alpha")
  end

end

function title:update(dt)
  if title.phase == 0 then
  elseif title.phase == 1 then
  elseif title.phase == 2 then
    -- Do something and change state
    game_state_manager:change_state(constants.PL_ACT)
  end
end

function title:handle_keypress(key)
  if key == "return" then
    title.anim_state = constants.OPENING
  end
  
end

return title