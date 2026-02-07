stack_menu = {}
stack_menu.state = constants.STACK_MENU

constants = require('constants')
local debug = require('lldebugger')

function stack_menu:on_state_enter()
  debug.print("stack_menu on_state_enter")
end

function stack_menu:on_state_exit()
  debug.print("stack_menu on_state_exit")
end

function stack_menu:get_state()
  return self 
end
return stack_menu