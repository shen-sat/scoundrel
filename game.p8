pico-8 cartridge // http://www.pico-8.com
version 32
In order to run this code:
- open pico 8 terminal
- navigate to where this code is located (you can use `folder` command to help)
- load the file:  `load game.p8`
- run the file:   `run game.p8`

__lua__
function _init()
  counter = 0
end

function _update()
  counter = counter + 1
end 

function _draw()
  cls()
  print(counter, 7, 7)
end 