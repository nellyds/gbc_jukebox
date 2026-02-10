game_state_manager = {}
local pl_act = require('game_states/pl_act')
local debug = require('lldebugger')
local player_menu = require('game_states/player_menu')
local stack_menu = require('game_states/stack_menu')
local constants = require('constants')
local dialogue = require('game_states/dialogue_menu')
function game_state_manager:change_state(arg)
    --debug.print("Changing state to: "..arg)
    local next_state = self:get_state(arg)
    local previous_state = self:get_state(_G.game.state)
    if previous_state then
        previous_state:on_state_exit()
    end
    _G.game.state = next_state.state
    next_state:on_state_enter()

end
function game_state_manager:on_state_end(entity, state, callback)
entity:on_state_end()
end

function game_state_manager:get_state(arg)
   if arg == constants.PL_ACT then
    return pl_act
   elseif arg == constants.PLAYER_MENU then
    return player_menu
   elseif arg == constants.STACK_MENU then
    return stack_menu
   elseif arg == constants.DIALOGUE then
    return dialogue
   end
end

return game_state_manager
