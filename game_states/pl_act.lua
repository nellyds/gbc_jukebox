pl_act = {}
pl_act.state= constants.PL_ACT
constants = require('constants')
local debug = require('lldebugger')
function pl_act:on_state_enter()
  debug.print("pl_act on_state_enter")
end
function pl_act:on_state_exit()
  debug.print("pl_act on_state_exit")
end

function pl_act:get_state()
  return self 
end
return pl_act