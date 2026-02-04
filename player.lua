player = {}
player.x = 100
player.y = 100
player.d="r"
player.dx=0
player.dy=0
player.w=16
player.h=16
player.game_mode = "pl_move"
debug = require('lldebugger')
dialogue = require('dialogue')
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

function player:player_update(dt,world,dialogue)
    if player.game_mode == "pl_move" then 
        _player_move_input(dt,world)
    end

end


function _player_move_input(dt,world)
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
end

function player:handle_keypress(key)
   if key=="v" and self.game_mode=="dialogue" then
        table.remove(dialogue.messages,1)
        if #dialogue.messages == 0 then
            self.game_mode = "pl_move"
        end
    elseif key=="v" and self.game_mode=="pl_move" then
                    local cols,len
            if self.d=="u" then
                cols, len = world:queryRect(player.x,player.y-10,16,16)
            elseif player.d=="d" then
            cols, len =world:queryRect(player.x,player.y+10,16,16)
            elseif player.d=="l" then
                cols, len =world:queryRect(player.x-8,player.y,16,16)
            elseif player.d=="r" then
                cols, len =world:queryRect(player.x+8,player.y,16,16)
            end
            _read_message(cols,len,game_mode)
    end

end

function _read_message(cols,len,game_mode) 
        for i=1,len do
            if cols[i].type=="int_obj" then
             --   debug.breakpoint()
                    player.game_mode="dialogue"
                    dialogue:add_message(player.game_mode.." "..cols[i].text)
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
