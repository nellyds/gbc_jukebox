
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
  room_generator = require('room_generator')
  songs:load_songs()
  local count = 0
  world = bump.newWorld(50)
  _init_world(world,room_objects)

end

function love.update(dt)
  player:player_update(dt,world)
  dialogue:dialogue_update(dt)
  record_stack:stack_update(dt)
  local actualx,actualy,cols,len = world:move(player,player.x+player.dx,player.y+player.dy,
  function(item, other) return other.type end
  )
for i=1,len do
 -- debug.print("Collision detected with " .. cols[i].other.type)
    if cols[i].other.type == "wall" then
  --    debug.print("Wall collision detected")
        -- Handle wall collision
    elseif cols[i].other.type == "door" then
    --  debug.print("Door collision detected")
        -- Handle door collision (maybe open it, transition rooms, etc.)
    end
end
  player.x=actualx
  player.y=actualy
end

function love.draw()
    room_generator:draw_room(game.room)
    for i,l in ipairs(room_objects) do
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("fill", l.x,l.y,l.w,l.h)
      love.graphics.setColor(255,255,255)
    end
    player:draw_player()
    record_player:draw_record_player()
    record_player:draw_player_menu()
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
  debug.print("Player added to world")
  -- Initialize objects before adding walls
  record_stack.x = 128
  record_stack.y = 64
  record_player.x = 192
  record_player.y = 64
  game_world:add_walls(game.room)
end


function love.keypressed(key)
  input:handle_keypress(key)
end