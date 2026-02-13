game_world = {}
local floor_tile = love.graphics.newImage("sprites/environment/floor.png")
function game_world:draw_room()
  for i=1,12,1 do
    for j=1,16,1 do
      love.graphics.draw(floor_tile, (i-1)*64, (j-1)*64)
    end
  end
end

return game_world