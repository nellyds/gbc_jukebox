player_menu = {}
player_menu.state= constants.PLAYER_MENU
require('constants')
local debug = require('lldebugger')

function player_menu:on_state_enter()
  
  _G.record_player.menu_open=true
  _G.record_stack.has_record=true
end

function player_menu:on_state_exit()
  _G.record_player.menu_open=false
end

function player_menu:get_state()
  return self 
end

return player_menu