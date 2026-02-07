dialogue = {}
dialogue.messages = {}
debug = require('lldebugger')
function dialogue:dialogue_update(dt)
  -- This function is called from player_update when key is pressed
end


function dialogue:dialogue_draw(dt)
   if #self.messages >0 then
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill",25,395,2005,50)
    love.graphics.setColor(0,0,0)
    love.graphics.printf(self.messages[1],30,400,200,"center")
    love.graphics.setColor(255,255,255)
  end
    
end

function dialogue:add_message(message)
  for i,m in ipairs(message) do
  table.insert(self.messages,m)
  end
end

return dialogue