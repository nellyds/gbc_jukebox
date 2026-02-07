player_menu = {}
player_menu.state= constants.PLAYER_MENU
require('constants')
local debug = require('lldebugger')

function player_menu:on_state_enter()
  debug.print("player_menu on_state_enter")
end

function player_menu:on_state_exit()
  debug.print("player_menu on_state_exit")
end

function player_menu:get_state()
  return self 
end

return player_menu