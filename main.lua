
if arg[2] == "debug" then
    require("lldebugger").start()
end



function love.load()
  game_font = love.graphics.newFont("assets/game_font.ttf",12)
  love.graphics.setFont(game_font)  
  constants = require('src/constants')
  record_player = require('src/record_player')
  record_stack = require('src/record_stack')
  game_state_manager = require('src/game_state_manager')
  room_transition = require('src/game_states/room_transition')
  player_state_manager = require('src/player_state_manager')
  player = require('src/player')
  bump = require ('lib/bump')
  room_objects = require('/src/room_objects') 
  lldebugger = require('src/lldebugger')
  dialogue = require('src/dialogue') 
  input = require('src/input')
  maps = require('assets/maps')
  game= {}
  game.state = constants.PL_ACT
  game.room = constants.ROOM_1
  songs = require('audio/songs')
  game_world = require('src/game_world')
  songs:load_songs()
  local count = 0
  world = bump.newWorld(50)
  _init_world(world,room_objects)

end

function love.update(dt)
  player:player_update(dt,world)
  dialogue:dialogue_update(dt)
  record_stack:stack_update(dt)
  if game.state == constants.ROOM_TRANSITION then
    room_transition:update(dt, game.room)
  end
  if game.state ~= constants.ROOM_TRANSITION then
    local actualx,actualy,cols,len = world:move(player,player.x+player.dx,player.y+player.dy,
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
      world:update(player,cols[i].other.pcx*64,cols[i].other.pcy*64)
      return
    end
end
  player.x=actualx
  player.y=actualy  
  end
  
end

function love.draw()

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

function _init_world(world,room_objects)
local object = {
  {type="message",
  text="first box"
  },
  {type="message",
  text="a second message"
  },
  {type="message",
  text="a third message"
  },
  {
    type="prompt",
    text="Do you want to continue?",
    options={
      {text="Yes",action=game_state_manager,arg=constants.PLAYER_MENU},
      {text="No",action=game_state_manager,arg=constants.PL_ACT}
    }
  }
}

  world:add(player,player.x,player.y,player.w,player.h)
  game_world:add_walls(game.room)
end


function love.keypressed(key)
  input:handle_keypress(key)
end