function create_context(x,y,move_speed)
  local context = {
    move_speed = move_speed,
    state = 'idle',
    top_row = {
      x_points = { x + (92 - x),x + (66 - x),x + (40 - x),x },
      y = y
    },
    bottom_row = {
      x_points = {x + (27 - x), x + (53 - x), x + (79 - x)},
      y = y + (75 - y)
    },
    cards = {create_card(40,y,'foo','bar')},
    update = function(self)
      for card in all(self.cards) do
        card:update()
      end

      if self:is_complete() then 
        self:set_state('idle')
        gamepad.disabled = false
      end
      
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
      -- check if cards are all in position
      for i=1, #self.cards do
        local card = self.cards[i]

        if not (card.x == self.top_row.x_points[i]) then result = false end
        if card.facedown then result = false end
      end

      return (result and self:is_full())
    end,
    deal = function(self)
      -- arrange cards positions
      for i=1, #self.cards do
        local card_x = self.cards[i].x + flr(self.move_speed)
        if card_x > self.top_row.x_points[i] then
          self.cards[i].x = self.top_row.x_points[i]
        else
          self.cards[i].x += flr(self.move_speed)
        end
      end
      -- arrange cards faceup
      for i=1, #self.cards do
        local card = self.cards[i]
        if card.x >= self.top_row.x_points[i] and card.facedown then card:set_state('flip') end
      end
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return context
end