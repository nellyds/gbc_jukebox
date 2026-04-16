room_transition = {}
room_transition.state = constants.ROOM_TRANSITION
room_transition.room = nil
room_transition.timer = 0
local constants = require('src/constants')
local game_world = require('src/game_world')
local transition = require('src/transition')
local enter_sound = love.audio.newSource("audio/boss_door.wav", "static")
room_transition.dest = nil
room_transition.animation_state = constants.OPENING
function room_transition:on_state_enter()
    enter_sound:play()
end

function room_transition:on_state_exit()
    room_transition.room = nil
    room_transition.timer = 0
    _G.transition.state = constants.CLOSED
    _G.transition.timer = 0
    room_transition.dest = nil
end

function room_transition:update(dt)
    room_transition.timer = room_transition.timer + dt
    if room_transition.timer >=.4 and room_transition.timer < .8 then
        debug.print("Changing room to: " .. room_transition.dest)
        game_world:change_rooms(room_transition.dest)
    end
    if room_transition.timer >=.8 then
        game_state_manager:change_state(constants.PL_ACT)
    end
end

function room_transition:set_dest(dest)
    room_transition.dest = dest
end

function room_transition:draw()

end

function room_transition:get_state()
  return self
end
return room_transition