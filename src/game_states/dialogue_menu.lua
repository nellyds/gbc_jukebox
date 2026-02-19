local constants = require('src/constants')
local dialogue_menu = {}
local debug = require('src/lldebugger')
dialogue_menu.state = constants.DIALOGUE

function dialogue_menu:on_state_enter()

end
function dialogue_menu:on_state_exit()

end
function dialogue_menu:get_state()
  return self 
end
return dialogue_menu
