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
  -- print(debugger,10,10,7)
  print(#context.bottom_cards,50,50,7)
  for card in all(all_cards) do
    card:draw()
  end
  cursor:draw()
end

function start_game()
  #include card/create_card.lua
  #include card/card_animations.lua
  #include create_deck.lua
  #include create_context.lua
  #include create_gamepad.lua
  #include create_dealer.lua
  #include create_cursor.lua
  #include shared.lua
  
  first_card_x = 14
  first_card_y = 34
  move_speed = 6

  context = create_context(first_card_x, first_card_y, move_speed)

  all_cards = {}

  deck_x = first_card_x
  deck_y = -16
  deck = create_deck(deck_x, deck_y)
  for card in all(deck) do
    add(all_cards, card)
  end

  hero_x = context:hero_slot().x
  hero_y = 129
  hero = create_card(hero_x,hero_y,'hero',20)
  add(all_cards, hero)

  torch_x = context:torch_slot().x
  torch_y = 129
  torch = create_card(torch_x,torch_y,'torch')
  add(all_cards, torch)

  dealer = create_dealer(deck,hero,torch,context)

  gamepad = create_gamepad(context, dealer)
  set_gamepad(context,gamepad)
  set_gamepad(dealer,gamepad)

  cursor = create_cursor(context)
  set_gamepad(cursor, gamepad)
  
  current_time = 0
  game.update = game_update
end

function game_update()
  gamepad_debug = 'disabled'
  gamepad:update()
  dealer:update()
  for card in all(all_cards) do
    card:update()
  end
  cursor:update()
  current_time += 1
end

function set_gamepad(object,gamepad)
  object.gamepad = gamepad
end