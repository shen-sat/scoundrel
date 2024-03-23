function create_cursor(context)
  -- cursor x, y = card_x + 10, card_y + 33
  local cursor = {
    draw = function(self)
      local card_x = 14
      local card_y = 34
      local x, y = card_x + 10, card_y + 33
      local col = 7

      line(x,y,x+1,y,col)
      line(x - 1,y+1,x+2,y+1,col)
      line(x - 2,y+2,x+3,y+2,col)
      line(x - 3,y+3,x+4,y+3,col)
    end
  }

  return cursor
end