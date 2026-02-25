title_menu = {}
title_menu.state = constants.TITLE_MENU
constants = require('src/constants')
local debug = require('src/lldebugger')

function title_menu:on_state_enter()
  -- TODO: Implement title menu enter logic
end

function title_menu:on_state_exit()
  -- TODO: Implement title menu exit logic
end

function title_menu:get_state()
  return self 
end

return title_menu
