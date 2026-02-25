transitions = {}
transitions.sequence = {}

function transitions:update()
 for i,transition in ipairs(transitions.sequence) do
  transition.anim_time = transition.anim_time + 1
  if transition.anim_time > transition.duration then
    table.remove(transitions.sequence, i)
  end
  if transition.anim_time % (transition.duration/12) == 0 then
    if transition.dir == "in" then
      transition.increment = transition.increment + .1
    elseif transition.dir == "out" then
      transition.increment = transition.increment - .1
    end
  end
 end
end

function transitions:add_transition(color, duration,dir)
  table.insert(transitions.sequence, 
  {color=color, duration=duration, increment =0, anim_time=0,dir=dir})
end

function transitions:draw()
  for i,transition in ipairs(transitions.sequence) do
    love.graphics.setColor(transition.color.r,
    transition.color.g,transition.color.b,transition.increment)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255,255,255)
  end
end
return transitions