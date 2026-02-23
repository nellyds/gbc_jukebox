record_player = {}
record_player.x = 256
record_player.y= 64
record_player.w=64
record_player.h=64
record_player.text="My record player"
record_player.col=constants.RECORD_PLAYER
record_player.type="slide"
record_player.menu_open=false
record_player.has_record=false
constants = require('src/constants')
record_player.options = {"Play","Stop","Esc"}
record_player.menu_select=1
record_player.anim_time=0
record_player.has_record=false
record_player.menu_y_offset = -20
record_player.menu_y_offset_close=-20
record_player.menu_y_offset_open=58
local menu_state = {
      OPENING="opening",
  CLOSING="closing",
  OPEN="open",
  CLOSED="closed"
}
local cursor_select = love.audio.newSource("audio/cursor_select.wav", "static")
local cursor_move = love.audio.newSource("audio/cursor_move.wav", "static")
local put_away = love.audio.newSource("audio/put_away.wav", "static")
local debug = require('src/lldebugger')
local play_active = love.graphics.newImage("sprites/ui/play_active.png")
local play_inactive = love.graphics.newImage("sprites/ui/play_inactive.png")
local stop_active = love.graphics.newImage("sprites/ui/stop_active.png")
local stop_inactive = love.graphics.newImage("sprites/ui/stop_inactive.png")
local esc_active = love.graphics.newImage("sprites/ui/eject_active.png")
local esc_inactive = love.graphics.newImage("sprites/ui/eject_inactive.png")
local util = require('lib/util')
local menu_ui = {
    {
        active = play_active,
        inactive = play_inactive
    },
    {
        active = stop_active,
        inactive = stop_inactive
    },
    {
        active = esc_active,
        inactive = esc_inactive
    }
}
function record_player:playSong()
    love.audio.stop()
    local song = _G.player.carrying_song.source
    love.audio.play(song)
end
function record_player:record_player_update(dt)
  self.anim_time = self.anim_time + 10
  if (self.anim_time % 30 == 0) then
    self.anim_time =0
  end
  if self.menu_state == constants.OPENING then
    debug.print("Opening")
    if self.anim_time % 30 == 0 then
        debug.print("Menu y offset: " .. self.menu_y_offset)
      self.menu_y_offset = self.menu_y_offset + 10
      debug.print("Menu y offset after increment: " .. self.menu_y_offset)
    end
    if self.menu_y_offset >= self.menu_y_offset_open then
      debug.print("Opening complete")
      debug.print("Menu y offset: " .. self.menu_y_offset)
      self.menu_state = constants.OPEN
      self.menu_y_offset = self.menu_y_offset_open
    end
  elseif self.menu_state ==constants.CLOSING then 
    debug.print("Closing")
    if self.anim_time % 60 == 0 then
      self.menu_y_offset = self.menu_y_offset - 10
    end
    if self.menu_y_offset <= self.menu_y_offset_close then
      self.menu_y_offset = self.menu_y_offset_close
      self.menu_state = constants.CLOSED
      self.menu_open = false
    end
  end
end

function record_player:draw_player_menu()
    if self.menu_open == true then
        util.draw_rect(170, self.menu_y_offset, 120, 56, 6,{r=100,g=165,b=255})
        for i=1,#menu_ui,1 do
            local option = menu_ui[i]
            if i == self.menu_select then
                love.graphics.draw(option.active, 180 + (i-1)*34, self.menu_y_offset + 12)
            else
                love.graphics.draw(option.inactive, 180 + (i-1)*34, self.menu_y_offset + 12)
            end
        end
    end
end

function record_player:handle_keypress(key)
    if key=="left" and self.menu_select > 1 then
        self.menu_select = self.menu_select - 1
        love.audio.play(cursor_move)
    elseif key=="right" and self.menu_select < #self.options then
        self.menu_select = self.menu_select + 1
        love.audio.play(cursor_move)
    elseif key==constants.BUTTON_ONE then
        if self.options[self.menu_select] == "Play" then
            self:playSong()
            game_state_manager:change_state(constants.PL_ACT)
            player_state_manager:change_state(constants.PL_IDLE)
        elseif self.options[self.menu_select] == "Stop" then
            love.audio.stop()
            love.audio.play(put_away)
            game_state_manager:change_state(constants.PL_ACT)
            player_state_manager:change_state(constants.PL_CARRY_IDLE)
        elseif self.options[self.menu_select] == "Esc" then
            love.audio.play(put_away)
            game_state_manager:change_state(constants.PL_ACT)
            player_state_manager:change_state(constants.PL_CARRY_IDLE)
        end
    elseif key==constants.BUTTON_TWO then
      self.menu_open = not self.menu_open
      _G.game.state=constants.PL_ACT
    end
end

return record_player