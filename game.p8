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

  context = create_context(first_card_x, first_card_y)

  deck_x = first_card_x
  deck_y = -16
  deck = create_deck(deck_x, deck_y, context)
end

function _update()
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  deck:draw()
  
end