local constants = require('constants')
local dialogue = {}
local debug = require('lldebugger')
dialgoue.state = constants.DIALOGUE

function dialogue:on_state_enter()
  debug.print("dialogue on_state_enter")
end
function dialogue:on_state_exit()
  debug.print("dialogue on_state_exit")
end
function dialogue:get_state()
  return self 
end
return dialogue
