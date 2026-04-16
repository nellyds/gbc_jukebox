pl_act = {}
pl_act.state= constants.PL_ACT
constants = require('src/constants')
local debug = require('src/lldebugger')
function pl_act:on_state_enter()
end
function pl_act:on_state_exit()
end

function pl_act:get_state()
  return self 
end
return pl_act