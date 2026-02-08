stack_menu = {}
stack_menu.state = constants.STACK_MENU
constants = require('constants')
local debug = require('lldebugger')

function stack_menu:on_state_enter()
  debug.print("stack_menu on_state_enter")
  _G.record_stack.menu_open=true
end

function stack_menu:on_state_exit()
  _G.record_stack.menu_open=false
end

function stack_menu:get_state()
  return self 
end
return stack_menu