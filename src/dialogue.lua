dialogue = {}
dialogue.messages = {}
local game_font = love.graphics.getFont()
debug = require('src/lldebugger')
dialogue.show_confirm = false
local util = require('lib/util')
local constants = require('src/constants')
dialogue.prompt_select=1
local dialogue_state = {
  DIALOGUE="dialogue",
  PROMPT="prompt"
}
dialogue.menu_state = constants.CLOSED
dialogue.y_offset = 600
dialogue.y_offset_close = 600
dialogue.y_offset_open = 448
dialogue.anim_time = 0
function dialogue:dialogue_update(dt)
  self.anim_time = self.anim_time + 10
  if (self.anim_time % 60 == 0) then
    self.anim_time = 0
  end
    if self.menu_state == constants.OPENING then
    if self.anim_time % 20 == 0 then
      self.y_offset = self.y_offset - 10
    end
    if self.y_offset <= self.y_offset_open then
      self.menu_state = constants.OPEN
      self.y_offset = self.y_offset_open
    end
  elseif self.menu_state ==constants.CLOSING then 
    self.y_offset = self.y_offset + 5
    if self.y_offset >= self.y_offset_close then
      self.y_offset = self.y_offset_close
      self.menu_state = constants.CLOSED
    end
  end
end


function dialogue:dialogue_draw(dt)
   if #self.messages >0 then
          util.draw_rect(4,self.y_offset, 634, 128, 6,{r=100,g=165,b=255})
    if self.messages[1].type == "message" then
      self.state = dialogue_state.DIALOGUE
      self:draw_message()
    elseif self.messages[1].type == "prompt" then
       self.state = dialogue_state.PROMPT
      self:draw_prompt()
    end
  end
end

function dialogue:handle_keypress(key)
  if self.state == dialogue_state.PROMPT then
    if key=="left" then
      self.prompt_select = self.prompt_select - 1
      if self.prompt_select < 1 then
        self.prompt_select = #self.messages[1].options
      end
    elseif key=="right" then
      self.prompt_select = self.prompt_select + 1
      if self.prompt_select > #self.messages[1].options then
        self.prompt_select = 1
      end
    elseif key==constants.BUTTON_ONE then

      local selected_option = self.messages[1].options[self.prompt_select]
      if selected_option and selected_option.action then
        if type(selected_option.action) == "function" then
          selected_option.action(selected_option.arg)
        elseif type(selected_option.action) == "table" and selected_option.action.change_state then
          selected_option.action:change_state(selected_option.arg)
        end
      end
      self.messages = {}
      self.state = nil
    end
  elseif self.state == dialogue_state.DIALOGUE then
    if key == "return" or key==constants.BUTTON_ONE then
      table.remove(self.messages, 1)
      if #self.messages == 0 then
        _G.game_state_manager:change_state(constants.PL_ACT)
      end
    end
  end
end

function dialogue:draw_message()
    self.show_confirm = true
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(love.graphics.newFont("assets/game_font.ttf",18))
    love.graphics.printf(self.messages[1].text,20,self.y_offset+22,620,"center")
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(game_font)

end
function dialogue:draw_prompt()
  self.show_confirm = false
    love.graphics.setColor(255,255,255)
    love.graphics.printf(self.messages[1].text,30,400,200,"center")
  for i,option in ipairs(self.messages[1].options) do
    love.graphics.printf(option.text,40 +(40*i),self.y_offset+22,200,"center")
  end  
  love.graphics.printf(">",10 +(50*self.prompt_select),430,200,"center")
end

function dialogue:add_message(message)
  for i,m in ipairs(message) do
  table.insert(self.messages,m)
  end
end

return dialogue