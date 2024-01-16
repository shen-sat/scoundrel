function create_context(x,y,move_speed)
  local context = {
    move_speed = move_speed,
    state = idle,
    y = y,
    x_points = {92,66,40,14},
    cards = {create_card(66,y,'foo','bar')},
    update = function(self)
      if self:is_complete() then self:set_state('idle') end
      
      if self.state == 'deal' then self:deal() end
    end,
    draw = function(self)
      for card in all(self.cards) do
        card:draw()
      end
    end,
    is_full = function(self)
      return #self.cards > 3
    end,
    is_complete = function(self)
      local result = true
      for i=1, #self.cards do
        if not (self.cards[i].x == self.x_points[i]) then result = false end
      end

      return (result and self:is_full())
    end,
    deal = function(self)
      counter += 1
      for i=1, #self.cards do
        local card_x = self.cards[i].x + flr(self.move_speed)
        if card_x > self.x_points[i] then
          self.cards[i].x = self.x_points[i]
        else
          self.cards[i].x += flr(self.move_speed)
        end
      end
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return context
end