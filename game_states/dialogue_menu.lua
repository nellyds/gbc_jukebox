local constants = require('constants')
local dialogue_menu = {}
local debug = require('lldebugger')
dialogue_menu.state = constants.DIALOGUE

function dialogue_menu:on_state_enter()
  debug.print("dialogue on_state_enter")
end
function dialogue_menu:on_state_exit()
  debug.print("dialogue on_state_exit")
end
function dialogue_menu:get_state()
  return self 
end
return dialogue_menu
