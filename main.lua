
if arg[2] == "debug" then
    require("lldebugger").start()
end



function love.load()
  game_font = love.graphics.newFont("assets/game_font.ttf",12)
  love.graphics.setFont(game_font)
  constants = require('constants')
  record_player = require('record_player')
  record_stack = require('record_stack')
  game_state_manager = require('game_state_manager')
  room_transition = require('game_states/room_transition')
  player_state_manager = require('player_state_manager')
  player = require('player')
  bump = require ('lib/bump')
  room_objects = require('room_objects') 
  lldebugger = require('lldebugger')
  dialogue = require('dialogue') 
  input = require('input')
  maps = require('assets/maps')
  game= {}
  game.state = constants.PL_ACT
  game.room = constants.ROOM_1
  songs = require('audio/songs')
  game_world = require('game_world')
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
    room_transition:update(dt)
  end
  if game.state ~= constants.ROOM_TRANSITION then
    local actualx,actualy,cols,len = world:move(player,player.x+player.dx,player.y+player.dy,
  function(item, other) return other.type end
  )
for i=1,len do
    if cols[i].other.type == "slide" then
    elseif cols[i].other.col == constants.DOOR then
      game_state_manager:change_state(constants.ROOM_TRANSITION)
      if cols[i].other.pcx and cols[i].other.pcy then
        debug.print("Setting player position to: " .. cols[i].other.pcx*64 .. ", " .. tostring(cols[i].other.pcy*64).." in  " .. tostring(cols[i].other.destination))
        player.x = cols[i].other.pcx*64
        player.y = cols[i].other.pcy*64
        
      end
      game_world:change_rooms(cols[i].other.destination)
      debug.print("Player position after change: " .. player.x .. ", " .. player.y)
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
    for i,l in ipairs(room_objects) do
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("fill", l.x,l.y,l.w,l.h)
      love.graphics.setColor(255,255,255)
    end
    player:draw_player()
    love.graphics.setColor(255,255,255)
    record_stack:draw_record_stack()
    record_stack:draw_song_menu()
    dialogue:dialogue_draw(dt)
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