room_transition = {}
room_transition.state = constants.ROOM_TRANSITION
room_transition.room = nil
room_transition.timer = 0
local constants = require('constants')
function room_transition:on_state_enter()
end

function room_transition:on_state_exit()
    room_transition.room = nil
    room_transition.timer = 0
end

function room_transition:update(dt)
    room_transition.timer = room_transition.timer + dt
    if room_transition.timer >= 1 then
        game_state_manager:change_state(constants.PL_ACT)
    end
end

function room_transition:get_state()
  return self
end
return room_transition