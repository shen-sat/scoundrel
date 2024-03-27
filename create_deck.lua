function create_deck(x,y)
  local suits = {'spade','club','diamond','heart'}
  
  local unshuffled_cards = {}

  for i=2, 14  do
  	for suit in all(suits) do
  		local card = create_card(x,y,suit,i)
  		add(unshuffled_cards, card)
  	end
  end

  local shuffled_cards = {}

  for _i=1, #unshuffled_cards  do
  	local card = rnd(unshuffled_cards) -- Get a random card
  	del(unshuffled_cards, card)
  	add(shuffled_cards, card)
  end

  for card in all(shuffled_cards) do
    assert(card.value < 15, "card value:"..card.value.." is greater than 14!")
    assert(card.value > 1, "card value:"..card.value.." is less than 2!")
  end

  return shuffled_cards
end