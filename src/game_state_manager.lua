game_state_manager = {}
local pl_act = require('src/game_states/pl_act')
local debug = require('src/lldebugger')
local player_menu = require('src/game_states/player_menu')
local stack_menu = require('src/game_states/stack_menu')
local constants = require('src/constants')
local dialogue = require('src/game_states/dialogue_menu')
local room_transition = require('src/game_states/room_transition')
local title_menu = require('src/game_states/title_menu')
function game_state_manager:change_state(arg)
    local next_state = self:get_state(arg)
    local previous_state = self:get_state(_G.game.state)
    debug.print("Changing state from " .. previous_state.state .. " to " .. next_state.state)
    if previous_state then
        debug.print("Previous state: " .. previous_state.state)
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
   elseif arg == constants.ROOM_TRANSITION then
    return room_transition
   elseif arg == constants.TITLE_MENU then
    return title_menu
   end
end

return game_state_manager
