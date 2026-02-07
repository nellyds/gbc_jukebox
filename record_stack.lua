record_stack = {}
record_stack.x=100
record_stack.y=200
record_stack.w=16
record_stack.h=16
record_stack.menu_select=1
record_stack.text="My stack of records"
record_stack.type=constants.STACK_MENU
record_stack.menu_open=false
local constants = require('constants')

local game_state_manager = require('game_state_manager')
local pl_act = require('game_states/pl_act')
local player_state_manager = require('player_state_manager')

function record_stack:draw_song_menu()
  if self.menu_open == true then
    local y_offset = 0
    for i=1,#_G.songs.list,1 do
      love.graphics.setColor(255,255,255)
      love.graphics.rectangle("line", 50, 70 + y_offset, 200, 16)
      love.graphics.printf(_G.songs.list[i].name, 50, 70 + y_offset, 200, "center")
      love.graphics.setColor(255,255,255)
      y_offset = y_offset + 40
    end
    love.graphics.circle("fill",40, 74 + (self.menu_select-1)*40,8)
  else
  end
end

function record_stack:handle_keypress(key)
    if key=="up" and self.menu_select > 1 then
        self.menu_select = self.menu_select - 1
    elseif key=="down" and self.menu_select < #_G.songs.list then
        self.menu_select = self.menu_select + 1
    elseif key==constants.BUTTON_ONE then
      record_stack:select_record()
    elseif key==constants.BUTTON_TWO then
      self.menu_open = not self.menu_open
      player_state_manager:change_state(constants.PL__CARRY_IDLE) 
      game_state_manager:change_state(pl_act)
    end
end

function record_stack:select_record()
  if self.menu_select < #_G.songs.list then
     _G.player.carrying_song = _G.songs.list[self.menu_select]
     self.menu_open = false
     player_state_manager:change_state(constants.PL_CARRY_IDLE)
     game_state_manager:change_state(pl_act)
  else
     self.menu_open = false
     player_state_manager:change_state(constants.PL_IDLE)
     game_state_manager:change_state(pl_act)
  end
end

function record_stack:draw_record_stack()
  love.graphics.setColor(0,255,0) 
  love.graphics.rectangle("fill", self.x, self.y, 16, 16)
  love.graphics.setColor(255,255,255) 
end

return record_stack