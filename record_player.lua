record_player = {}
record_player.x = 240
record_player.y= 240
record_player.w=16
record_player.h=16
record_player.text="My record player"
record_player.col='cross'
record_player.type=constants.PLAYER_MENU
record_player.menu_open=false
record_player.has_record=false
constants = require('constants')
record_player.options = {"Play","Stop","Esc"}
record_player.menu_select=1
record_player.has_record=false
local debug = require('lldebugger')

function record_player:playSong()
    love.audio.stop()
    local song = _G.player.carrying_song.source
    love.audio.play(song)
end

function record_player:draw_record_player()
  img = love.graphics.newImage("sprites/record_player.png")
  love.graphics.draw(img,self.x,self.y)
end

function record_player:draw_player_menu()
    if self.menu_open == true then
        for i=1,#self.options,1 do
            love.graphics.setColor(255,255,255)
            love.graphics.rectangle("line", 50 + (i-1)*150, 70, 150, 20)
            love.graphics.printf(self.options[i], 50 + (i-1)*150,70,200,"center")
        end
        love.graphics.circle("fill",50+((self.menu_select-1)*150),70,8)
    end
end

function record_player:handle_keypress(key)
    if key=="left" and self.menu_select > 1 then
        self.menu_select = self.menu_select - 1
    elseif key=="right" and self.menu_select < #self.options then
        self.menu_select = self.menu_select + 1
    elseif key==constants.BUTTON_ONE then
        if self.options[self.menu_select] == "Play" then
            self:playSong()
            game_state_manager:change_state(pl_act)
            player_state_manager:change_state(constants.PL_IDLE)
        elseif self.options[self.menu_select] == "Stop" then
            love.audio.stop()
        elseif self.options[self.menu_select] == "Esc" then
            game_state_manager:change_state(pl_act)
            player_state_manager:change_state(constants.PL_CARRY_IDLE)
        end

        self.menu_open = not self.menu_open
    elseif key==constants.BUTTON_TWO then
      self.menu_open = not self.menu_open
      _G.game.state=constants.PL_ACT
    end
end

return record_player