
if arg[2] == "debug" then
    require("lldebugger").start()
end



function love.load()

  constants = require('constants')
  record_player = require('record_player')
  record_stack = require('record_stack')
  player = require('player')
  bump = require ('lib/bump')
  room = require('room') 
  lldebugger = require('lldebugger')
  dialogue = require('dialogue') 
  input = require('input')
  game= {}
  game.state = constants.PL_ACT
  songs = require('audio/songs')
  songs:load_songs()
  local count = 0
  world = bump.newWorld(50)
  _init_world(world,room)

end

function love.update(dt)
  player:player_update(dt,world)
  dialogue:dialogue_update(dt)
  local actualx,actualy,cols,len = world:move(player,player.x+player.dx,player.y+player.dy,
  player:col_filter(player,other)
  )
  player.x=actualx
  player.y=actualy
end

function love.draw()
    love.graphics.rectangle("fill",player.x,player.y,16,16)
    for i,l in ipairs(room) do
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("fill", l.x,l.y,l.w,l.h)
      love.graphics.setColor(255,255,255)
    end
    record_player:draw_record_player()
    record_player:draw_player_menu()
    love.graphics.setColor(255,255,255)
    record_stack:draw_record_stack()
    record_stack:draw_song_menu()
    dialogue:dialogue_draw(dt)
  end

function _init_world(world,room)
  world:add(player,player.x,player.y,player.w,player.h)
  room:add_object(40,100,{"first box","a second message","a third message"},world)
  world:add(record_player,record_player.x,record_player.y,record_player.w,record_player.h)
  world:add(record_stack,record_stack.x,record_stack.y,record_stack.w,record_stack.h)
end

function love.keypressed(key)
  input:handle_keypress(key)
end