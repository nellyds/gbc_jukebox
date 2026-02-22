game_world = {}
local maps = require('assets/maps')
local texts = require('assets/texts')
local wall = love.graphics.newImage("sprites/environment/l_wall.png")
local corner = love.graphics.newImage("sprites/environment/ul_corner.png")
local l_door = love.graphics.newImage("sprites/environment/l_door.png")
local r_door = love.graphics.newImage("sprites/environment/r_door.png")
local u_door = love.graphics.newImage("sprites/environment/u_door.png")
local d_door = love.graphics.newImage("sprites/environment/d_door.png")
local floor = love.graphics.newImage("sprites/environment/floor.png")
local edge = love.graphics.newImage("sprites/environment/edge.png")
local util = require('lib/util')
function game_world:draw_room(room)
   local map_arg = maps[room]['map']
  local count = 0
  for i=1,#map_arg,1 do
    for j=1,#map_arg[1],1 do
      count = count + 1
      local cur = map_arg[i][j]
      if cur == 7 then
        --left wall
        love.graphics.draw(wall, (j-1)*64, (i-1)*64)
      elseif cur ==6 then
        --top wall
        love.graphics.draw(wall, (j-1)*64, (i-1)*64,math.rad(90),1,1,0,64)
      elseif cur ==9 then
        --bottom wall
        love.graphics.draw(wall, (j-1)*64, (i-1)*64,math.rad(270),1,1,64,0)
      elseif cur ==8 then
        --right wall
        love.graphics.draw(wall, (j-1)*64, (i-1)*64,math.rad(180),1,1,64,64)      
      elseif cur == 2 then
        --top left
        love.graphics.draw(corner, (j-1)*64, (i-1)*64)
      elseif cur == 3 then
        --top right
        love.graphics.draw(corner, (j-1)*64, (i-1)*64, math.rad(90),1,1,0,64) 
      elseif cur == 4 then
        --bottom left
        love.graphics.draw(corner, (j-1)*64, (i-1)*64, math.rad(270),1,1,64,0)
      elseif cur == 5 then
        --bottom right
        love.graphics.draw(corner, (j-1)*64, (i-1)*64,math.rad(180),1,1,64,64)
      elseif cur == 1 then
        love.graphics.draw(floor, (j-1)*64, (i-1)*64)
      elseif cur == 10 then
        love.graphics.draw(l_door, (j-1)*64, (i-1)*64)
      elseif cur == 11 then
        love.graphics.draw(r_door, (j-1)*64, (i-1)*64)
      elseif cur == 12 then
        love.graphics.draw(u_door, (j-1)*64, (i-1)*64)
      elseif cur == 13 then
        love.graphics.draw(d_door, (j-1)*64, (i-1)*64)
      elseif cur == 14 then
        --bottom left
        love.graphics.draw(edge, (j-1)*64, (i-1)*64)
      elseif cur == 15 then
        --bottom right
        love.graphics.draw(edge, (j-1)*64, (i-1)*64, math.rad(90),1,1,0,64)
      elseif cur == 16 then
        --top left
        love.graphics.draw(edge, (j-1)*64, (i-1)*64, math.rad(180),1,1,64,64)
      elseif cur == 17 then
        --top right
        love.graphics.draw(edge, (j-1)*64, (i-1)*64, math.rad(270),1,1,64,0)
      end
    end
  end
  local objs = maps[room]['objects']
  for i=1,#objs,1 do
    local obj = objs[i]
    if obj.img then
      love.graphics.draw(love.graphics.newImage(obj.img), obj.x, obj.y)
    end
  end
end

function game_world:add_walls(room)
--  debug.print("Adding walls for room: " .. room)
  local map_arg = maps[room]['map']
  local wallvals= {6,7,8,9}
  local doorvals= {10,11}
  for i=1,#map_arg,1 do
    for j=1,#map_arg[1],1 do
      local cur = map_arg[i][j]
      if util:table_contains(wallvals, cur) then
        _G.world:add({type="slide", col="wall"}, (j-1)*64, (i-1)*64, 64, 64)        
      end
    end
  end
  local objs = maps[room]['objects']
  for i=1,#objs,1 do
    local obj = objs[i]
    if obj.col == "record_stack" then
     _G.world:add(_G.record_stack,_G.record_stack.x,_G.record_stack.y,64,64)
    elseif obj.col == "record_player" then
      _G.world:add(_G.record_player,_G.record_player.x,_G.record_player.y,64,64)
    elseif obj.col == "int_obj" then
      _G.world:add({type=obj.type, col=obj.col, text=texts[obj.text_key]}, obj.x, obj.y, obj.w, obj.h)
    end
  end
  local doors = maps[room]['doors']
  debug.print("Doors: " .. #doors)
  for i=1,#doors,1 do
    local door = doors[i]
    _G.world:add({type=door.type, col=door.col, destination=door.destination, pcx=door.pcx, pcy=door.pcy}, door.x, door.y, 72, 64)
    local items = _G.world:getItems()
  end
end

function game_world:change_rooms(room)
  game.room = room
  local items = _G.world:getItems()
  for _, item in ipairs(items) do
    if item.col ~= "player" then
      _G.world:remove(item)
    end
  end
  self:add_walls(room)
end

return game_world