game_loop = {}

local player = require('src/player')
local dialogue = require('src/dialogue')
local record_stack = require('src/record_stack')
local record_player = require('src/record_player')
local constants = require('src/constants')
local room_transition = require('src/game_states/room_transition')
local game_state_manager = require('src/game_state_manager')
local world = require('src/game_world')

function game_loop:update(dt,world)
    player:player_update(dt,world)
  dialogue:dialogue_update(dt)
  record_stack:stack_update(dt)
  record_player:record_player_update(dt)
  if game.state == constants.ROOM_TRANSITION then
    room_transition:update(dt, game.room)
  end
  if game.state ~= constants.ROOM_TRANSITION then
    local actualx,actualy,cols,len = _G.world:move(player,player.x+player.dx,player.y+player.dy,
  function(item, other) return other.type end
  )
for i=1,len do
    if cols[i].other.type == "slide" then
    elseif cols[i].other.col == constants.DOOR then
      room_transition:set_dest(cols[i].other.destination)
      game_state_manager:change_state(constants.ROOM_TRANSITION )
      if cols[i].other.pcx and cols[i].other.pcy then
        player.x = cols[i].other.pcx*64
        player.y = cols[i].other.pcy*64
      end
      _G.world:update(player,cols[i].other.pcx*64,cols[i].other.pcy*64)
      return
    end
end
  player.x=actualx
  player.y=actualy  
  end
      

end



function game_loop:draw()
    game_world:draw_room(game.room)
    player:draw_player()
    if game.state == constants.ROOM_TRANSITION then
      transition:draw_room_transition()
    end
    love.graphics.setColor(255,255,255)
    record_stack:draw_record_stack()
    record_stack:draw_song_menu()
    dialogue:dialogue_draw(dt)

    record_player:draw_player_menu()
end

return game_loop