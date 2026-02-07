game_state_manager = {}
local pl_act = require('game_states/pl_act')
local debug = require('lldebugger')
local player_menu = require('game_states/player_menu')
local stack_menu = require('game_states/stack_menu')


function game_state_manager:change_state(entity)
    debug.print("game_state_manager: "..tostring(entity.state))
_G.game.state = entity.state
entity:on_state_enter()

end
function game_state_manager:on_state_end(entity, state, callback)
entity:on_state_end()
end

return game_state_manager
