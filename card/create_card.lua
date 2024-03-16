function create_card(x,y,suit,value)
  local card = {
    suit = suit,
    value = value,
    x = x,
    y = y,
    state = 'idle',
    facedown = true,
    frame_index = 1,
    state_change_time = 0,
    update = function(self)
      local frame_index = get_frame_index(self,current_time)
      
      if frame_index == self.frame_index then return end

      if frame_index > #self:animations()[self.state]:frames() then
        if self.state == 'flip' then self.facedown = (not self.facedown) end
        
        self:set_state('idle')

      else
        self:set_frame_index(frame_index)
      end
    end,
    draw = function(self)
      local frames = self:animations()[self.state]:frames()
      local index = self.frame_index
      
      frames[index]()
    end,
    set_state = function(self,new_state)
      if new_state == self.state then return end

      self.frame_index = 1
      self.state_change_time = current_time

      if new_state then
        self.state = new_state  
      else
        self.state = 'idle' 
      end
    end,
    set_frame_index = function(self,frame_index)
      self.frame_index = frame_index
    end,
    animations = function(self)
      return card_animations(self)
    end
  }



  return card
end