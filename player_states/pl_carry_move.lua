constants = require('constants')
pl_carry_move =  {}
pl_carry_move.state = constants.PL_CARRY_IDLE
debug = require('lldebugger')
function pl_carry_move:on_state_enter()
  debug.print("pl_carry on_state_enter")
end
function pl_carry_move:on_state_exit()
  debug.print("pl_carry on_state_exit")
end
function pl_carry_move:update(dt)
end
function pl_carry_move:draw(dt)
end
return pl_carry_move