title_menu = {}
title_menu.state = constants.TITLE_MENU
constants = require('src/constants')

local debug = require('src/lldebugger')
local theWorldHasTurned = love.audio.newSource("audio/TheWorldHasTurnedAndLeftMeHere.wav", 'stream')
function title_menu:on_state_enter()

end

function title_menu:on_state_exit()
 theWorldHasTurned:play()
end

function title_menu:get_state()
  return self 
end

return title_menu
