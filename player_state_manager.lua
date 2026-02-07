player_state_manager = {}
local pl_idle = require('player_states/pl_idle')
local pl_move = require('player_states/pl_move')
local pl_carry = require('player_states/pl_carry')
function player_state_manager:change_state(entity)
    _G.player.state = entity.state
    entity:on_state_enter()
end
function player_state_manager:on_state_end(entity, state, callback)
    entity:on_state_end()
end
return player_state_manager