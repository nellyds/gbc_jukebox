player_state_manager = {}
local pl_idle = require('player_states/pl_idle')
local pl_move = require('player_states/pl_move')
local pl_carry_idle = require('player_states/pl_carry_idle')
local pl_carry_move = require('player_states/pl_carry_move')
debug = require('lldebugger')
constants = require('constants')
function player_state_manager:change_state(arg)
    local exit_state = get_state(_G.player.state)
    local enter_state = get_state(arg)
    if exit_state then
        exit_state:on_state_exit()
    end
    _G.player.state = enter_state.state
    enter_state:on_state_enter()
end
function get_state(str)
  if str== constants.PL_CARRY_IDLE then
    return pl_carry_idle
  elseif str== constants.PL_CARRY_MOVE then
    return pl_carry_move
  elseif str== constants.PL_MOVE then
    return pl_move
  elseif str== constants.PL_IDLE then
    return pl_idle
  end
end

function player_state_manager:get_current_state()
    return _G.player.state
end

return player_state_manager