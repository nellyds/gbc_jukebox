player = {}
player.x = 100
player.y = 100
player.d="r"
player.dx=0
player.dy=0
player.w=16
player.h=16

-- Debug function that outputs to multiple places
local function debug_print(...)
    local args = {...}
    local output = table.concat(args, " ")
    
    -- Output to LÖVE console
    print(output)
    
    -- Try to output to VSCode if debugger is available
    if lldebugger and lldebugger.print then
        lldebugger.print(output)
    end
end


function player:player_update(dt,world)
  
    if love.keyboard.isDown("up") then
        player.d = "u"
        player.dy = -1
    elseif love.keyboard.isDown("down") then
        player.d = "d"
        player.dy = 1
    else
        player.dy = 0
    end
    if love.keyboard.isDown("left") then
        player.d = "l"
        player.dx = -1
    elseif love.keyboard.isDown("right") then
        player.d = "r"
        player.dx = 1
    else
        player.dx = 0
    end
    
    if love.keyboard.isDown("v") then
        local cols,len
        if player.d=="u" then
            cols, len = world:queryRect(player.x,player.y-10,16,16)
        elseif player.d=="d" then
           cols, len =world:queryRect(player.x,player.y+10,16,16)
        elseif player.d=="l" then
            cols, len =world:queryRect(player.x-8,player.y,16,16)
        elseif player.d=="r" then
            cols, len =world:queryRect(player.x+8,player.y,16,16)
        end
        _read_message(cols,len)
    end
end

function _read_message(cols,len) 
        for i=1,len do
            
            if cols[i].type=="int_obj" then
                if love.keyboard.isDown("v") then
                    debug_print("Reading "..tostring(cols[i].text))
                end
             end
        end
end

function player_draw(dt)
 if (player.d== "u") then
    
 elseif (player.d=="d") then

 elseif (player.d=="l") then
 
elseif (player.d=="r") then

 end
end

function player:col_filter(player, other)
    if other then
        return other.col
    else return nil
    end

end

return player
