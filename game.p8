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
  #include create_shape.lua

  first_card_x = 14
  first_card_y = 34
  move_speed = 6

  context = create_context(first_card_x, first_card_y, move_speed)

  deck_x = first_card_x
  deck_y = -16
  deck = create_deck(deck_x, deck_y, context)

  debug = ''
  time = 0
  shape = create_shape()
end

function _update()
  if btnp(⬅️) then
    shape:set_state('flip')
  end
  shape:update()
  context:update()
  deck:update()
  time += 1
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  shape:draw()
end