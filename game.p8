pico-8 cartridge // http://www.pico-8.com
version 32
In order to run this code:
- open pico 8 terminal
- navigate to where this code is located (you can use `folder` command to help)
- load the file:  `load game.p8`
- run the file:   `run game.p8`

__lua__
function _init()
  #include card.lua
end

function _update()
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  -- using this to see where deck should sit
  rectfill(0,0,14,14,7)
  -- card
  card:draw(14,33)
end