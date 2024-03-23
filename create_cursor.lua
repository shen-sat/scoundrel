function create_cursor(context)
  local cursor = {
    card_x = function(self)
      if self.is_top_row then
        return context:top_cards_ordered()[self.card_index].x
      end
    end,
    card_y = function(self)
      if self.is_top_row then
        return context.top_row.y
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

      if self.state == 'right' then
        local cards
        if context.top_row.y == self:card_y() then
          cards = context:top_cards_ordered()
        else
          cards = context.bottom_cards
        end

        self.card_index +=1
        if self.card_index > #cards then self.card_index = 1 end

        self:set_state('idle')
        gamepad.disabled = false
      end
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