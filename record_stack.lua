record_stack = {}
record_stack.x=100
record_stack.y=200
record_stack.w=64
record_stack.h=64
record_stack.menu_select=1
record_stack.text="My stack of records"
record_stack.type=constants.STACK_MENU
record_stack.carrying_song = nil
record_stack.menu_open=false
local constants = require('constants')
local debug = require('lldebugger')
local stack_state = {
  OPENING="opening",
  CLOSING="closing",
  OPEN="open",
  CLOSED="closed"
}
record_stack.menu_state = stack_state.CLOSED
record_stack.y_offset=400
record_stack.y_offset_close=1000
record_stack.y_offset_open=400

local util = require('lib.util')
local game_state_manager = require('game_state_manager')
local player_state_manager = require('player_state_manager')
local record_stack_img = love.graphics.newImage("sprites/environment/record_stack.png")
function record_stack:draw_song_menu()
  if self.menu_open == true then
    local y_offset = 0
    local song_count = 0
    for _ in pairs(_G.songs.list) do
      song_count = song_count + 1
    end

    util.draw_rect(40, self.y_offset, 520, song_count * 40 + 20, 6,{r=100,g=165,b=255})
    local i = 1
    for key, song in pairs(_G.songs.list) do
      love.graphics.setColor(255,255,255)
      love.graphics.printf(song.name, 50, self.y_offset+20 + y_offset, 500, "center")
      love.graphics.setColor(255,255,255)
      y_offset = y_offset + 40
    end
    love.graphics.circle("fill",80, 74 + (self.menu_select-1)*40,8)
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
      game_state_manager:change_state(constants.PL_ACT)
    end
end

function record_stack:select_record()
  if self.menu_select < #_G.songs.list then
     _G.player.carrying_song = _G.songs.list[self.menu_select]
     self.menu_open = false
     debug.print("Selected song: " .. _G.player.carrying_song.name)
     player_state_manager:change_state(constants.PL_CARRY_IDLE)
     game_state_manager:change_state(constants.PL_ACT)
  else
     self.menu_open = false
     player_state_manager:change_state(constants.PL_IDLE)
     game_state_manager:change_state(constants.PL_ACT)
  end
end

function record_stack:draw_record_stack()
  love.graphics.draw(record_stack_img, self.x, self.y)
end

return record_stack