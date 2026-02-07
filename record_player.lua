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
function record_player:playSong(song)
    love.audio.stop()
    love.audio.play(song)
end

function record_player:draw_record_player()
  love.graphics.setColor(0,25,255) 
  love.graphics.rectangle("fill", self.x, self.y, 16, 16)
  love.graphics.setColor(255,255,255) 
end

function record_player:draw_player_menu()
    if self.menu_open == true then
        for i=1,#self.options,1 do
            love.graphics.setColor(255,255,255)
            love.graphics.rectangle("line", 50 + (i-1)*40, 70, 200, 16)
            love.graphics.printf(self.options[i], 50 + (i-1)*40, 70 , 200, "center")
        end
        love.graphics.circle("fill",40, 74 + (self.menu_select-1)*40,8)
    end
end

function record_player:handle_keypress(key)
    if key=="left" and self.menu_select > 1 then
        self.menu_select = self.menu_select - 1
    elseif key=="right" and self.menu_select < #self.options then
        self.menu_select = self.menu_select + 1
    elseif key==constants.BUTTON_ONE then
      self.menu_open = not self.menu_open
    elseif key==constants.BUTTON_TWO then
      self.menu_open = not self.menu_open
      _G.game.state=constants.PL_ACT
    end
end

return record_player