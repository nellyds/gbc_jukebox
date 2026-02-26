
if arg[2] == "debug" then
    require("lldebugger").start()
end



function love.load()
  transitions = require('src/transitions')
  title_img = love.graphics.newImage("sprites/ui/title.png")
  game_font = love.graphics.newFont("assets/game_font.ttf",12)
  love.graphics.setFont(game_font)  
  love.window.setMode(644,644 )
  constants = require('src/constants')
  record_player = require('src/record_player')
  record_stack = require('src/record_stack')
  game_state_manager = require('src/game_state_manager')
  room_transition = require('src/game_states/room_transition')
  player_state_manager = require('src/player_state_manager')
  player = require('src/player')
  bump = require ('lib/bump')
  title = require('src/title')
  room_objects = require('/src/room_objects') 
  lldebugger = require('src/lldebugger')
  dialogue = require('src/dialogue') 
  input = require('src/input')
  game_loop = require('src/game_loop')
  maps = require('assets/maps')
  game= {}
  game.state = constants.TITLE_MENU
  game.room = constants.ROOM_1
  songs = require('audio/songs')
  game_world = require('src/game_world')
  songs:load_songs()
  world = bump.newWorld(50)
  _init_world(world,room_objects)

end

function love.update(dt)
  transitions:update()
  if game.state ~= constants.TITLE_MENU then
    game_loop:update(dt)
  else
   title:update(dt) 
  end 
end

function love.draw()
  if game.state == constants.TITLE_MENU then
    title:draw()
  else
    game_loop:draw()
    
  end
    transitions:draw()
end

function _init_world(world,room_objects)
local object = {
  {type="message",
  text="first box"
  },
  {type="message",
  text="a second message"
  },
  {type="message",
  text="a third message"
  },
  {
    type="prompt",
    text="Do you want to continue?",
    options={
      {text="Yes",action=game_state_manager,arg=constants.PLAYER_MENU},
      {text="No",action=game_state_manager,arg=constants.PL_ACT}
    }
  }
}

  world:add(player,player.x,player.y,player.w,player.h)
  game_world:add_walls(game.room)
end


function love.keypressed(key)
  input:handle_keypress(key)
end