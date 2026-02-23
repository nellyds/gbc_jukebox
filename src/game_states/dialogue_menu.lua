local constants = require('src/constants')
local dialogue_menu = {}
local debug = require('src/lldebugger')
local dialogue = require('src/dialogue')
dialogue_menu.state = constants.DIALOGUE

function dialogue_menu:on_state_enter()
  _G.dialogue.menu_state = constants.OPENING
end
function dialogue_menu:on_state_exit()
  _G.dialogue.menu_state = constants.CLOSING
end
function dialogue_menu:get_state()
  return self 
end
return dialogue_menu
