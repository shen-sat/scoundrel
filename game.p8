pico-8 cartridge // http://www.pico-8.com
version 32
In order to run this code:
- open pico 8 terminal
- navigate to where this code is located (you can use `folder` command to help)
- load the file:  `load game.p8`
- run the file:   `run game.p8`

__lua__
function _init()
  game = {}
  start_game()
end

function _update()
  game.update()
end 

function _draw()
  cls()
  -- bg
  rectfill(0,0,127,127,1)
  -- other objects
  print(gamepad_debug,90,90,7)
  deck:draw()
  context:draw()
end

function start_game()
  #include create_card.lua
  #include create_deck.lua
  #include create_context.lua
  #include create_gamepad.lua
  
  first_card_x = 14
  first_card_y = 34
  move_speed = 6

  context = create_context(first_card_x, first_card_y, move_speed)

  deck_x = first_card_x
  deck_y = -16
  deck = create_deck(deck_x, deck_y, context)

  gamepad = create_gamepad(deck, context)
  set_gamepad(context, gamepad)
  
  current_time = 0
  game.update = game_update
end

function game_update()
  gamepad_debug = 'disabled'
  gamepad:update()
  context:update()
  deck:update()
  current_time += 1
end

function set_gamepad(object,gamepad)
  object.gamepad = gamepad
end