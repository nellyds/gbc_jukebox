title_menu = {}
title_menu.state = constants.TITLE_MENU
constants = require('src/constants')
local songs = require('audio/songs')
local debug = require('src/lldebugger')
local theWorldHasTurned = love.audio.newSource("audio/TheWorldHasTurnedAndLeftMeHere.wav", 'stream')
function title_menu:on_state_enter()
  

end

function title_menu:on_state_exit()
  debug.print(songs.list[1].name)
 theWorldHasTurned:play()
end

function title_menu:get_state()
  return self 
end

return title_menu
