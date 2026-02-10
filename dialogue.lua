dialogue = {}
dialogue.messages = {}
debug = require('lldebugger')
dialogue.show_confirm = false
dialogue.prompt_select=1
local constants = require('constants')
local dialogue_state = {
  DIALOGUE="dialogue",
  PROMPT="prompt"
}
function dialogue:dialogue_update(dt)
  -- This function is called from player_update when key is pressed
end


function dialogue:dialogue_draw(dt)
   if #self.messages >0 then
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
        debug.print("Executing action with arg: "..selected_option.arg)
        debug.print("Action type: "..type(selected_option.action))
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
    end
  end
end

function dialogue:draw_message()
    self.show_confirm = true
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill",25,395,2005,50)
    love.graphics.setColor(0,0,0)
    love.graphics.printf(self.messages[1].text,30,400,200,"center")

end
function dialogue:draw_prompt()
  self.show_confirm = false
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill",25,395,2005,50)
    love.graphics.setColor(0,0,0)
    love.graphics.printf(self.messages[1].text,30,400,200,"center")
  for i,option in ipairs(self.messages[1].options) do
    love.graphics.printf(option.text,40 +(40*i),430,200,"center")
  end  
  love.graphics.printf(">",10 +(50*self.prompt_select),430,200,"center")
end

function dialogue:add_message(message)
  for i,m in ipairs(message) do
  table.insert(self.messages,m)
  end
end

return dialogue