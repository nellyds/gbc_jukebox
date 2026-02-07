pl_carry_idle = {}
pl_carry_idle.state = constants.PL_CARRY_IDLE
local constants = require('constants')

debug = require('lldebugger')
function pl_carry_idle:on_state_enter()
  debug.print("pl_carry_idle on_state_enter")
end
function pl_carry_idle:on_state_exit()
  debug.print("pl_carry_idle on_state_exit")
end

return pl_carry_idle