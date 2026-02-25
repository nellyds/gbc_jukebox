
input = {}
local player = require('src/player')
local record_stack = require('src/record_stack')
local record_player = require('src/record_player')
local constants = require('src/constants')
local debug = require('src/lldebugger')
local game_state_manager = require('src/game_state_manager')
local title = require('src/title')

function input:handle_keypress(key)
  if _G.game.state==constants.PL_ACT then
  player:handle_keypress(key)
  elseif _G.game.state==constants.STACK_MENU then
  record_stack:handle_keypress(key)
  elseif _G.game.state==constants.PLAYER_MENU then
  record_player:handle_keypress(key)
  elseif _G.game.state==constants.DIALOGUE then
  dialogue:handle_keypress(key)
  elseif _G.game.state==constants.TITLE_MENU then
  title:handle_keypress(key)
  end

end


return input