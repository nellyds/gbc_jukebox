
if arg[2] == "debug" then
    require("lldebugger").start()
end

local player = require('player')
local bump = require ('lib/bump')
local room = require('room') 
local lldebugger = require('lldebugger')
local world
function love.load()
 world = bump.newWorld(50)
  _init_world()

end
function love.update()
  player:player_update(dt,world)
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
  end

function _init_world()
  world:add(player,player.x,player.y,player.w,player.h)
 room:add_object(40,100,"first box",world)
 room:add_object(120,100,"second box",world)

end