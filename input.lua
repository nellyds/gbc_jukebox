
input = {}

function input:key_input(dt)
 if love.keyboard.isDown("w") then
   radius= radius+1    
 elseif love.keyboard.isDown("s") then
   radius=radius-1
 end
end

return input