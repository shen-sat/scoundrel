function create_card(x,y,suit,value)
  local card = {
    suit = suit,
    value = value,
    x = x,
    y = y,
    facedown = true,
    update = function()
    end,
    draw = function(self)
      x1 = self.x + 21
      y1 = self.y + 31

      rectfill(x,y,x1,y1,6)
      pset(x,y,1)
      pset(x,y1,1)
      pset(x1,y,1)
      pset(x1,y1,1)

      if self.facedown then
        rectfill(x + 2, y + 2, x1 - 2, y1 - 2, 1)
      end
    end
  }

  return card
end