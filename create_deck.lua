function create_deck(x,y)
  local deck = {
  	x = x,
  	y = y,
  	cards = {},
  	facedown = true,
  	draw = function(self)
  		x1 = self.x + 21
  		y1 = self.y + 31

  		rectfill(self.x,self.y,x1,y1,14)
  		pset(self.x,self.y,1)
  		pset(self.x,y1,1)
  		pset(x1,self.y,1)
  		pset(x1,y1,1)

  		if self.facedown then
  		  rectfill(self.x + 2, self.y + 2, x1 - 2, y1 - 2, 1)
  		end
  	end
  }

  local suits = {'spade','club','diamond','heart'}
  
  for i=1, 13  do
  	for suit in all(suits) do
  		local card = create_card(0,0,suit,i)
  		add(deck.cards, card)
  	end
  end

  return deck
end