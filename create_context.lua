function create_context(x,y,move_speed)
  local context = {
    move_speed = move_speed,
    state = 'idle',
    top_row = {
      x_points = { x, x + (40 - x), x + (66 - x), x + (92 - x) },
      y = y
    },
    bottom_row = {
      x_points = {x + (27 - x), x + (53 - x), x + (79 - x)},
      y = y + (75 - y)
    },
    hero_slot = function(self)
      local slot = {
        x = self.bottom_row.x_points[2],
        y = self.bottom_row.y,
      }

      return slot
    end,
    torch_slot = function(self)
      local slot = {
        x = self.bottom_row.x_points[3],
        y = self.bottom_row.y,
      }

      return slot
    end,
    top_cards = {},
    top_cards_ordered = function(self)
      local ordered_cards = {}
      local x = #self.top_cards + 1
      
      for i=1, #self.top_cards do
        add(ordered_cards, self.top_cards[x - i])
      end

      return ordered_cards
    end,
    bottom_cards = {},
    update = function(self)
      if self:is_complete() then 
        self:set_state('idle')
        self.gamepad.disabled = false
      end
      
      if self.state == 'arrange' then self:arrange() end
    end,
    is_full = function(self)
      return #self.top_cards > 3
    end,
    is_complete = function(self)
      local result = true
      -- check if top_cards are all in position
      for i=1, #self.top_cards do
        local card = self.top_cards[i]

        if not (card.x == self.top_row.x_points[5 - i]) then result = false end
        if card.facedown then result = false end
      end

      return (result and self:is_full())
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return context
end