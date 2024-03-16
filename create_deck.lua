function create_deck(x,y,context)
  local deck = {
  	context = context,
  	x = x,
  	y = y,
  	cards = {},
    state = 'idle',
  	update = function(self)
  		if self.state == 'deal' then
  			local move_speed = context.move_speed

  			if not self.context:is_full() then
  			  local dealt_card = self.cards[1]
  			  if dealt_card.y + move_speed < self.context.top_row.y then
  			    dealt_card.y += move_speed
  			  else
  			    dealt_card.y = self.context.top_row.y
  			    del(self.cards, dealt_card)
  			    add(self.context.top_cards, dealt_card)
  			    if self.context:is_full() then self:set_state('idle') end
  			  end
  			end
  		end
  		
  	end,
  	draw = function(self)
  		for card in all(self.cards) do
  			card:draw()
  		end
  	end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  local suits = {'spade','club','diamond','heart'}
  
  local unshuffled_cards = {}

  for i=1, 13  do
  	for suit in all(suits) do
  		local card = create_card(deck.x,deck.y,suit,i,deck)
  		add(unshuffled_cards, card)
  	end
  end

  for _i=1, #unshuffled_cards  do
  	local card = rnd(unshuffled_cards) -- Get a random card
  	del(unshuffled_cards, card)
  	add(deck.cards, card)
  end

  return deck
end