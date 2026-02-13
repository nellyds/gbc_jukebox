stack_menu = {}
stack_menu.state = constants.STACK_MENU
constants = require('constants')
local debug = require('lldebugger')

function stack_menu:on_state_enter()
  _G.record_stack.menu_open=true
  _G.record_stack.state=constants.OPENING
end

function stack_menu:on_state_exit()
  _G.record_stack.menu_open=false
  _G.record_stack.state=constants.CLOSED
end

function stack_menu:get_state()
  return self 
end
return stack_menu