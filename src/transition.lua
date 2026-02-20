transition = {}
transition.state = constants.CLOSED
transition.timer = 0

function transition:draw_room_transition()
  local height, width = love.graphics.getHeight(), love.graphics.getWidth()
  transition.timer = transition.timer + .02
  
  -- Venetian blinds parameters
  local strip_height = 20  -- Height of each blind strip
  local gap_size = 2       -- Gap between strips when open
  local num_strips = math.ceil(height / strip_height)
  
  -- Calculate progress (0 to 1)
  local progress = math.min(transition.timer / 2, 1)  -- 2 second transition
  
  if transition.timer < 2 then
    transition.state = constants.OPENING
  else
    transition.state = constants.CLOSED
    transition.timer = 0
  end
  
  if transition.state == constants.OPENING then
    love.graphics.setColor(0, 0, 0, 1)
    
    for i = 0, num_strips - 1 do
      local y_pos = i * strip_height
      local gap_progress = progress * gap_size
      love.graphics.rectangle("fill", 0, y_pos + gap_progress, width, strip_height - gap_progress * 2)
    end
    
  elseif transition.state == constants.CLOSED then
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, width, height)
  end
end

return transition
