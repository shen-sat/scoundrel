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

  foo = nil
  counter = 0
  shape = create_shape()
end

function _update()
  if btnp(⬅️) then
    shape.animation = shape.animations.flip
  end
  context:update()
  deck:update()
  counter += 1
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  shape:draw()
end