
if arg[2] == "debug" then
    require("lldebugger").start()
end



function love.load()
  player = require('player')
 bump = require ('lib/bump')
room = require('room') 
lldebugger = require('lldebugger')
dialogue = require('dialogue') 

 world = bump.newWorld(50)
  _init_world(world,room)

end

function love.update(dt)
  player:player_update(dt,world,dialogue)
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
    dialogue:dialogue_draw(dt)
  end

function _init_world(world,room)
  world:add(player,player.x,player.y,player.w,player.h)
 room:add_object(40,100,"first box",world)
 room:add_object(120,100,"second box",world)

end

function love.keypressed(key)
  player:handle_keypress(key)
end