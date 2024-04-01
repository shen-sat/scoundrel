function create_suit(type, card)
  local suit = {
    type = type,
    card = card,
    x = function(self)
      return self.card.x
    end,
    y = function(self)
      return self.card.y
    end,
    state = 'idle',
    frame_index = 1,
    state_change_time = 0,
    update = function(self)
      if card.selected then
        self:set_state('selected')
      else
        self:set_state('idle')
      end

      local frame_index = get_frame_index(self,current_time)
      
      if frame_index == self.frame_index then return end

      self:set_frame_index(frame_index)
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
      return suit_animations(self)
    end
  }

  return suit
end