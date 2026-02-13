util = {}

function util.draw_rect(rect_x,rect_y,rect_w,rect_h,rect_line, color)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", rect_x,rect_y,rect_w,rect_h)

    love.graphics.setLineWidth(rect_line)
    love.graphics.setColor(color.r/255, color.g/255, color.b/255)
    love.graphics.line(rect_x+rect_line+2, rect_y+rect_line+1,rect_x+rect_w-rect_line-1,rect_y+rect_line-1)
    love.graphics.line(rect_x+rect_line, rect_y+rect_line+1+2,rect_x+rect_line-1,rect_y+rect_h-rect_line-1)
    love.graphics.line(rect_x+rect_w-rect_line+1, rect_y+rect_line+1,rect_x+rect_w-rect_line-1,rect_y+rect_h-rect_line-2)
    love.graphics.line(rect_x+rect_line+2, rect_y+rect_h-rect_line+1,rect_x+rect_w-rect_line-3,rect_y+rect_h-rect_line)
    love.graphics.setColor(255,255,255)
    --   love.graphics.line(rect_x+rect_w-rect_line+1, rect_y+rect_line+1,rect_x+rect_w-rect_line-1,rect_y+rect_h-rect_line-2)
 --   love.graphics.line(rect_x+rect_line+2, rect_y+rect_h-rect_line+1,rect_x+rect_w-rect_line-3,rect_y+rect_h-rect_line)
end

return util