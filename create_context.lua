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
    hero_slot = function(self)
      slot = {
        x = self.bottom_row.x_points[2],
        y = self.bottom_row.y,
      }

      return slot
    end,
    top_cards = {},
    bottom_cards = {},
    update = function(self)
      if self:is_complete() then 
        self:set_state('idle')
        gamepad.disabled = false
      end
      
      if self.state == 'deal' then self:deal() end
    end,
    is_full = function(self)
      return #self.top_cards > 3
    end,
    is_complete = function(self)
      local result = true
      -- check if top_cards are all in position
      for i=1, #self.top_cards do
        local card = self.top_cards[i]

        if not (card.x == self.top_row.x_points[i]) then result = false end
        if card.facedown then result = false end
      end

      return (result and self:is_full())
    end,
    deal = function(self)
      -- arrange top_cards positions
      for i=1, #self.top_cards do
        local card_x = self.top_cards[i].x + flr(self.move_speed)
        if card_x > self.top_row.x_points[i] then
          self.top_cards[i].x = self.top_row.x_points[i]
        else
          self.top_cards[i].x += flr(self.move_speed)
        end
      end
      -- arrange top_cards faceup
      for i=1, #self.top_cards do
        local card = self.top_cards[i]
        if card.x >= self.top_row.x_points[i] and card.facedown then card:set_state('flip') end
      end
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return context
end