function create_cursor(context)
  local cursor = {
    card_x = function(self)
      if self.is_top_row then
        return context:top_cards_ordered()[self.card_index].x
      else
        return context.bottom_cards[self.card_index].x
      end
    end,
    card_y = function(self)
      if self.is_top_row then
        return context.top_row.y
      else
        return context.bottom_row.y
      end
    end,
    is_top_row = true,
    card_index = 1,
    x_offset = 10,
    y_offset = 33,
    state = 'idle',
    context = context,
    update = function(self)
      if not context:is_complete() then return end

      local cards = context.top_row.y == self:card_y() and context:top_cards_ordered() or context.bottom_cards

      if self.state == 'right' then
        local new_index = self.card_index + 1
        if new_index <= #cards then self.card_index += 1 end
      elseif self.state == 'left' then
        local new_index = self.card_index - 1
        if new_index > 0 then self.card_index -= 1 end
      elseif self.state == 'up' then
        if (not self.is_top_row) and #context.top_cards > 0 then
          self.is_top_row = true
          self.card_index = 1
        end
      elseif self.state == 'down' then
        if self.is_top_row and #context.bottom_cards > 0 then
          self.is_top_row = false
          self.card_index = 1
        end
      end

      self:set_state('idle')
      gamepad.disabled = false
    end,
    draw = function(self)
      if not context:is_complete() then return end

      local x, y = self:card_x() + self.x_offset, self:card_y() + self.y_offset
      local col = 7

      for i=1, 4  do
        local index_minus_one = i - 1

        line(x - index_minus_one,y+index_minus_one,x+i,y+index_minus_one,col)  
      end
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return cursor
end