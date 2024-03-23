function create_cursor(context)
  local card_x = context.top_row.x_points[1]
  local card_y = context.top_row.y

  local x_offset = 10
  local y_offset = 33

  local initialize_x = card_x + x_offset
  local initialize_y = card_y + y_offset

  local cursor = {
    x = initialize_x,
    y = initialize_y,
    x_offset = x_offset,
    y_offset = y_offset,
    draw = function(self)
      local x, y = self.x, self.y
      local col = 7

      for i=1, 4  do
        local index_minus_one = i - 1

        line(x - index_minus_one,y+index_minus_one,x+i,y+index_minus_one,col)  
      end
    end
  }

  return cursor
end