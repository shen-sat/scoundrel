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

  deck_x = 14
  deck_y = -16
  deck = create_deck(deck_x, deck_y)
end

function _update()
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  deck:draw()
  
end