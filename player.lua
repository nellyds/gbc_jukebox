player = {}
player.x = 100
player.y = 100
player.d=constants.DIR_RIGHT
player.dx=0
player.dy=0
player.w=64
player.h=64
player.state = constants.PL_IDLE

local anim8 = require('lib/anim8')
debug = require('lldebugger')
local dialogue = require('dialogue')
local constants = require('constants')
local game_state_manager = require('game_state_manager')
local player_state_manager = require('player_state_manager')
local pl_act = require('game_states/pl_act')
local player_menu = require('game_states/player_menu')
local stack_menu = require('game_states/stack_menu')
local dialogue_menu = require('game_states/dialogue_menu')
local img = love.graphics.newImage("sprites/environment/record.png")
local idle_sheet = love.graphics.newImage("sprites/player/player_idle_sheet.png")
local walk_sheet = love.graphics.newImage("sprites/player/player_walk_sheet.png")
local idle_g = anim8.newGrid(64, 64, idle_sheet:getWidth(), idle_sheet:getHeight())
local walk_g = anim8.newGrid(64, 64, walk_sheet:getWidth(), walk_sheet:getHeight())
local walk_animations = {
    [constants.DIR_UP] = anim8.newAnimation(walk_g('1-2', constants.DIR_UP), .2),
    [constants.DIR_DOWN] = anim8.newAnimation(walk_g('1-2', constants.DIR_DOWN), .2),
    [constants.DIR_LEFT] = anim8.newAnimation(walk_g('1-2', constants.DIR_LEFT), .2),
    [constants.DIR_RIGHT] = anim8.newAnimation(walk_g('1-2', constants.DIR_RIGHT), .2)
}
local idle_animations = {
    [constants.DIR_UP] = anim8.newAnimation(idle_g('1-3', constants.DIR_UP), .2),
    [constants.DIR_DOWN] = anim8.newAnimation(idle_g('1-3', constants.DIR_DOWN), .2),
    [constants.DIR_LEFT] = anim8.newAnimation(idle_g('1-3', constants.DIR_LEFT), .2),
    [constants.DIR_RIGHT] = anim8.newAnimation(idle_g('1-3', constants.DIR_RIGHT), .2)
}
function player:player_update(dt)
    if _G.game.state==constants.PL_ACT then 
        if player_state_manager:get_current_state() == constants.PL_CARRY_IDLE then
            self:_player_carry_input(dt,world)
            idle_animation:update(dt)
        elseif player_state_manager:get_current_state() == constants.PL_CARRY_MOVE then
            self:_player_carry_move_input(dt,world)

        elseif player_state_manager:get_current_state() == constants.PL_MOVE then
            self:_player_move_input(dt,world)
            walk_animations[self.d]:update(dt)
        elseif player_state_manager:get_current_state() == constants.PL_IDLE then
            self:_player_move_input(dt,world)
            idle_animations[self.d]:update(dt)
        end
    end
end

function player:_player_carry_input(dt,world)
    if love.keyboard.isDown("up") then
        player.d = constants.DIR_UP
        player.dy = -1
    elseif love.keyboard.isDown("down") then
        player.d = constants.DIR_DOWN
        player.dy = 1
    else
        player.dy = 0
    end
    if love.keyboard.isDown("left") then
        player.d = constants.DIR_LEFT
        player.dx = -1
    elseif love.keyboard.isDown("right") then
        player.d = constants.DIR_DOWN
        player.dx = 1
    else
        player.dx = 0
    end
    if player.dx ~= 0 or player.dy ~= 0 then
        player_state_manager:change_state(constants.PL_CARRY_MOVE)
    else
        if player_state_manager:get_current_state() ~= constants.PL_CARRY_IDLE then
        player_state_manager:change_state(constants.PL_CARRY_IDLE)
        end
    end
end

function player:_player_move_input(dt,world)
    if love.keyboard.isDown("up") then
        player.d = constants.DIR_UP
        player.dy = -1
    elseif love.keyboard.isDown("down") then
        player.d = constants.DIR_DOWN
        player.dy = 1
    else
        player.dy = 0
    end
    if love.keyboard.isDown("left") then
        player.d = constants.DIR_LEFT
        player.dx = -1
    elseif love.keyboard.isDown("right") then
        player.d = constants.DIR_RIGHT
        player.dx = 1
    else
        player.dx = 0
    end
    if player.dx ~= 0 or player.dy ~= 0 then
        player_state_manager:change_state(constants.PL_MOVE)
    else 
        if player_state_manager:get_current_state() ~= constants.PL_IDLE then
        player_state_manager:change_state(constants.PL_IDLE)
        end
    end
end

function player:handle_keypress(key)
    if key==constants.BUTTON_ONE then
        if _G.game.state==constants.DIALOGUE then
            table.remove(dialogue.messages,1)
            if #dialogue.messages == 0 then
                game_state_manager:change_state(constants.PL_ACT)
                player_state_manager:change_state(constants.PL_IDLE)
            end
        elseif _G.game.state==constants.PL_ACT then
            local cols,len
                if self.d=="u" then
                    cols, len = world:queryRect(self.x,self.y-10,16,16)
                elseif self.d=="d" then
                    cols, len =world:queryRect(self.x,self.y+10,16,16)
                elseif self.d=="l" then
                    cols, len =world:queryRect(self.x-8,self.y,16,16)
                elseif self.d=="r" then
                    cols, len =world:queryRect(self.x+8,self.y,16,16)
                end
                player:_check_space(cols,len)
        end
    end
end

function player:_check_space(cols,len) 
        for i=1,len do
            if cols[i].type=="int_obj" then
               player_state_manager:change_state(constants.PL_IDLE) 
               game_state_manager:change_state(constants.DIALOGUE)
                    dialogue:add_message(cols[i].text)
            elseif cols[i].type==constants.STACK_MENU then
                   player_state_manager:change_state(constants.PL_IDLE) 
                   game_state_manager:change_state(constants.STACK_MENU)
            elseif cols[i].type==constants.PLAYER_MENU then
                    player_state_manager:change_state(constants.PL_IDLE) 
                    game_state_manager:change_state(constants.PLAYER_MENU)
                    cols[i].menu_open=true
            end
        end
end

function player:col_filter(player, other)
    if other then
        return other.col
    else return nil
    end

end

function player:draw_player()
    if player.state==constants.PL_MOVE then
    walk_animations[self.d]:draw(walk_sheet,self.x,self.y)
    elseif player.state==constants.PL_IDLE then
--        love.graphics.setColor(255,255,255)
--        love.graphics.draw(walk_r,self.x,self.y)
    idle_animations[self.d]:draw(idle_sheet,self.x,self.y)
    elseif player.state==constants.PL_CARRY_IDLE then
    
    elseif player.state==constants.PL_CARRY_MOVE then
    
    end

    if player.state==constants.PL_CARRY_IDLE or player.state==constants.PL_CARRY_MOVE then
      love.graphics.draw(img,self.x,self.y-64)
    end
end
return player
