function create_cursor(context)
  local card_x = context.top_row.x_points[1]
  local card_y = context.top_row.y

  local x_offset = 10
  local y_offset = 33

  local initialize_x = card_x + x_offset
  local initialize_y = card_y + y_offset

  local cursor = {
    card_x = card_x,
    card_y = card_y,
    x_offset = 10,
    y_offset = 33,
    state = 'idle',
    context = context,
    update = function(self)
      if self.state == 'right' then
        local x_points
        if context.top_row.y == self.card_y then
          x_points = context.top_row.x_points
        else
          x_points = context.bottom_row.x_points
        end

        local index
        for i=1, #x_points do
          local x_point = x_points[i]
          if self.card_x == x_point then index = i end 
        end

        index +=1
        if index > #x_points then index = 1 end

        self.card_x = x_points[index]
        self:set_state('idle')
        gamepad.disabled = false
      end
    end,
    draw = function(self)
      local x, y = self.card_x + self.x_offset, self.card_y + self.y_offset
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