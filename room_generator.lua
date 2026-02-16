game_world = {}
local maps = require('assets/maps')
local floor = love.graphics.newImage("sprites/environment/floor.png")
local d_wall = love.graphics.newImage("sprites/environment/d_wall.png")
local u_wall = love.graphics.newImage("sprites/environment/u_wall.png")
local l_wall = love.graphics.newImage("sprites/environment/l_wall.png")
local r_wall = love.graphics.newImage("sprites/environment/r_wall.png")
local dl_corner = love.graphics.newImage("sprites/environment/dl_corner.png")
local dr_corner = love.graphics.newImage("sprites/environment/dr_corner.png")
local ul_corner = love.graphics.newImage("sprites/environment/ul_corner.png")
local ur_corner = love.graphics.newImage("sprites/environment/ur_corner.png")

function game_world:draw_room()

   local map_arg = maps.room_1['map']
  local count = 0
  for i=1,#map_arg,1 do
    for j=1,#map_arg[1],1 do
      count = count + 1
      local cur = map_arg[i][j]
      if cur == 7 then
        love.graphics.draw(u_wall, (i-1)*64, (j-1)*64)
      elseif cur ==6 then
        love.graphics.draw(l_wall, (i-1)*64, (j-1)*64)
      elseif cur ==9 then
        love.graphics.draw(r_wall, (i-1)*64, (j-1)*64)
      elseif cur ==8 then
        love.graphics.draw(d_wall, (i-1)*64, (j-1)*64)      
      elseif cur == 2 then
        love.graphics.draw(ul_corner, (i-1)*64, (j-1)*64)
      elseif cur == 4 then
        love.graphics.draw(ur_corner, (i-1)*64, (j-1)*64) 
      elseif cur == 3 then
        love.graphics.draw(dl_corner, (i-1)*64, (j-1)*64)
      elseif cur == 5 then
        love.graphics.draw(dr_corner, (i-1)*64, (j-1)*64)
      elseif cur == 1 then
        love.graphics.draw(floor, (i-1)*64, (j-1)*64)
      end
    end
  end
end

function game_world:add_walls()
  local map_arg = maps.room_1['map']
  for i=1,#map_arg,1 do
    for j=1,#map_arg[1],1 do
      local cur = map_arg[i][j]
      if cur ~= 1 then
        _G.world:add({type="wall"}, (i-1)*64, (j-1)*64, 64, 64)        
      end
    end
  end
  local objs = maps.room_1['objects']
  debug.print("Objects: " .. #objs)
  for i=1,#objs,1 do
    local obj = objs[i]
    if obj.type == "record_stack" then
      _G.world:add(_G.record_stack, _G.record_stack.x, _G.record_stack.y, 64, 64)
    elseif obj.type == "record_player" then
      _G.world:add(_G.record_player, _G.record_player.x, _G.record_player.y, 64, 64)
    end
  end
end

return game_world