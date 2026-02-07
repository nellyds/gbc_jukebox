constants = require('constants')
pl_idle = {}
pl_idle.state = constants.PL_IDLE
function pl_idle:on_state_enter()
end
function pl_idle:on_state_exit()
end

function pl_idle:update(dt)
end
function pl_idle:draw(dt)
end
return pl_idle