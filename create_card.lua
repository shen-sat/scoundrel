function create_card(x,y,suit,value)
  local card = {
    suit = suit,
    value = value,
    x = x,
    y = y,
    facedown = true,
    update = function(self)
    end,
    draw = function(self)
      x1 = self.x + 21
      y1 = self.y + 31

      rectfill(self.x,self.y,x1,y1,7)
      pset(self.x,self.y,1)
      pset(self.x,y1,1)
      pset(x1,self.y,1)
      pset(x1,y1,1)

      if self.facedown then
        rectfill(self.x + 2, self.y + 2, x1 - 2, y1 - 2, 1)
      end
    end
  }

  return card
end