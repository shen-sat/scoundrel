pico-8 cartridge // http://www.pico-8.com
version 32
In order to run this code:
- open pico 8 terminal
- navigate to where this code is located (you can use `folder` command to help)
- load the file:  `load game.p8`
- run the file:   `run game.p8`

__lua__
function _init()
  #include create_card.lua
  #include create_deck.lua
  #include create_context.lua

  first_card_x = 14
  first_card_y = 34
  move_speed = 6

  context = create_context(first_card_x, first_card_y, move_speed)

  deck_x = first_card_x
  deck_y = -16
  deck = create_deck(deck_x, deck_y, context)
  
  foo = nil
  counter = 0
end

function _update()
  if btnp(⬅️) then
    deck.deal_phase = true
    context.arrange_phase = true
  end
  context:update()
  deck:update()
  
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  deck:draw()
  context:draw()
  print(foo, 7)
  print(#deck.cards, 7)
  print(#context.cards, 7)
  for c in all(context.cards) do
    print(c.x)
  end
  print(counter)
end