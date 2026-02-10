
input = {}
local player = require('player')
local record_stack = require('record_stack')
local record_player = require('record_player')
local constants = require('constants')
local debug = require('lldebugger')

function input:handle_keypress(key)
  if _G.game.state==constants.PL_ACT then
  player:handle_keypress(key)
  elseif _G.game.state==constants.STACK_MENU then
  record_stack:handle_keypress(key)
  elseif _G.game.state==constants.PLAYER_MENU then
  record_player:handle_keypress(key)
  elseif _G.game.state==constants.DIALOGUE then
  dialogue:handle_keypress(key)
  end
end


return input