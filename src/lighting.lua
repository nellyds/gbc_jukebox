lighting = {}

function lighting.new(radius, darkness)
    local self = {}
    self.radius = radius or 150
    self.darkness = darkness or 0.3
    self.canvas = love.graphics.newCanvas(644, 644)
    
    function self:update(player_x, player_y)
        love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        
        -- Draw darkness overlay
        love.graphics.setColor(0, 0, 0, self.darkness * 255)
        love.graphics.rectangle("fill", 0, 0, 644, 644)
        
        -- Cut out light area around player using subtractive blending
        love.graphics.setBlendMode("subtract")
        
        -- Draw the light area (subtracts darkness)
        local gradient_steps = 15
        for i = gradient_steps, 1, -1 do
            local step_radius = (self.radius / gradient_steps) * i
            local alpha = ((1 - (i - 1) / gradient_steps) * 255) * (1 - self.darkness)
            love.graphics.setColor(255, 255, 255, alpha)
            love.graphics.circle("fill", player_x + 32, player_y + 32, step_radius)
        end
        
        love.graphics.setBlendMode("alpha")
        love.graphics.setCanvas()
    end
    
    function self:draw()
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.canvas, 0, 0)
    end
    
    return self
end

return lighting
