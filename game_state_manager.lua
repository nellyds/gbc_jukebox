game_state_manager = {}
local pl_act = require('game_states/pl_act')
local debug = require('lldebugger')
local player_menu = require('game_states/player_menu')
local stack_menu = require('game_states/stack_menu')
local constants = require('constants')

function game_state_manager:change_state(entity)
    local previous_state = game_state_manager:get_state()
    _G.game.state = entity.state
    entity:on_state_enter()
    if previous_state then
        previous_state:on_state_exit()
    end

end
function game_state_manager:on_state_end(entity, state, callback)
entity:on_state_end()
end

function game_state_manager:get_state()
   local prevState =  _G.game.state
   if prevState ==constants.PL_ACT then
    return pl_act
   elseif prevState ==constants.PL_MENU then
    return player_menu
   elseif prevState ==constants.STACK_MENU then
    return stack_menu
   elseif prevState ==constants.DIALOGUE then
    return dialogue_menu
   end
end

return game_state_manager
