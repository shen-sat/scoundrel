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
  #include suit/create_suit.lua
  #include suit/suit_animations.lua
  
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
  torch = create_card(torch_x,torch_y,'torch',0)
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

__gfx__
11111116666666111111111111111111cccccc844444eeeccccc88844444444cccccccc44444e4eccccc8c8444444ee88888888ee444444c8cc44eecc8811111
11111666666666661111111111111111ccccccc4444eeeecccc888844444e4eccccc8c844444eeeccccc888eeeeeeeec8888888eee4444488cc4eeec88811111
11116666666666666611111111111111cccc8c8444eeeeeccc8888844444eeeccccc88844444444cccccccc4eeeeee4cccc888c4eee444488cceee4888c11111
11166666666666666661111111111111cccc8c8444eeeeecc8888cc44444444cccccccc44444eeeccccc8884444ee4ecccc88c844eee44488ccee4e88c811111
11666666666666666666111111111111cccc8c8444eeeeec8888cc844444eeeccccc88844444eeeccccc8884444ee4ecccc88c8444eeeee88ccee4e88c811111
16666666616166666666611111111111cccc8cc444eeeee8888ccc844444eeeccccc8884444eee4cccc888c44444ee4ccccc88c4444eeee88cceee4888c11111
16666666611166666666611111111111cccc8cc444e44448888ccc84444eee4cccc888c4444ee4ecccc88c84444444eccccccc84444eee488cceeeec88811111
66666666611166666666661111111111ccc8ccc4eee44448888ccc84444ee4ecccc88c84444ee4ecccc88c811111111111111114444ee4e8888ee44c88c11111
66666666611166666666661111111111cc8cccc4e4e4ee48888ccc84444ee4eccc888c8444eeee4ccccc88c11111111111111114444ee4e8888ee44c88c11111
66666666611166666666666111111111c8ccccc4e4e4ee488888cc8444eeee4c888888c4eeeeeeeccc88888111111111111111144444ee4888cee44c88c11111
66666666611166666666666611116611c8ccccc44ee4444888888cc4eeeeeee88888888eeeeeeeec888888811111111111111114444444e88c8ee44c88c11111
666666666666666666666666111666618cccccc4eee444488888888eeeeeeee88888888eeeeeeee8888888811111111111111111111111188c8ee44c88c11111
666666666666666666666666111666618c88888eeeee44488888888eeeeeeee88888888eeeeeeee88888888111111111111111111111111c88cee44c88c11111
666666666666666666666666666166118c88888eeeeee4488888888eeeeeeee88888888eeeeeeee88888888111111111111111111111111ccc8ee44c88c11111
166666666666666666666666666611118c88888eeeeeeee88888888eeeeeeee88888888eeeeeeee8888888811111111111111111111111111114e44cc8c11111
16661666666666666666666666666111c8c8888eeeeeeee88888888eeeeeeee88888888eeeeeeee8888888811111111111111111111111111111111111111111
11661116666666611661166666666111c8c8888eeeeeeee88888888eeeeeeee88888888eeeeeeee8888888811111111111111111111111111111111111111111
11166611666661116611166666666111cc8cc88eeeeeeee88888888eeeeeeee88888888eeeeeeee8888888811111111111111111111111111111111111111111
11116661111111666111166666666111ccc88cc1111111111111111eeeeeeee88888888eeeeeeee8888888811111111111111111111111111111111111111111
11111666666666661111116666611111ccccc8811111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111116666666111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
9999333399999922bbbb222233392222bbbb22999999333399992222bbbb22933322bbbb22226666633222222bb6666332222bb66663322222bb111111111111
9999399399999922bb2b222239932222b22b22999999399399992222b22b22399322bb2b2222666633322222bbb666333222bbb6663332222bbb111111111111
9999399933999922bb22bb22399322bb222b229999339993999922bb222b22399322bb22bb22666333622bbbbb266333622bbb2663336222bbb2111111111111
9999393993999922bb222b22399322bb222b229999399993999922bb222b22399322bb222b2266633632bbbbb2b66336322bb2b663363222bb2b111111111111
9999333993999922bb222b22399322bb222b229999393993999922bb222b22399322bb222b226333363bbbbbb2b66336322bb2b6633632bbbb2b111111111111
9999339993999922bb222b22399322bb222b229999333993999922bb222b22399322bb222b223333336bbbbbbb266333622bbb2633336bbbbbb2111111111111
9999399993999922bb222b22399322bb222b229999339993999922bb222b22399322bb222b223333333bbbbbbbb66333322bbbb333333bbbbbbb111111111111
9999393993999922bb222b22399322bb222b229999399993999922bb222b22399322bb222b2233333332bbbbbbb66333322bbbb333333bbbbbbb111111111111
9999333993999922bb222b22399322bb222b229999393993999922bb222b22399322bb222b22633333322bbbbbb6633332bbbbb3333332bbbbbb111111111111
9999333993999922bb222b22399322bb222b229999333993999922bb222b22399322bb222b22663333311111111663333bbbbbb33333322bbbbb111111111111
39993339939993b2bb222b2b3993b2bb222b2b39993339939993b2bb222b2b3993b2bb222b2b111111111111111663333bbbbbb6333331111111111111111111
33333399333333bbb22bbbbb3333bbbbb22bbb33333399333333bbb22bbbbb3333bbbbb22bbb111111111111111633333bbbbbb6633331111111111111111111
33333399333333bbb22bbbbb3333bbbbb22bbb33333399333333bbb22bbbbb3333bbbbb22bbb1111111111111113333332bbbbb1111111111111111111111111
9999333333999922bbbbb2223333222bbbbb229999333333999922bbbbb2223333222bbbbb2211111111111111133333322bbbb1111111111111111111111111
aaaaaa44ceeccccc44a444444cceeeeccc44aaaaa44eeeeeeecc111111111111111111111111111111111111111333333222bbb1111111111111111111111111
aaaaaaa4ceeccccc444444444eeeeeeecc4aaaaaaa4eeeeeeeec1111111111111111111111111111111111111116333331111111111111111111111111111111
4aaaaaaacceeeeec4444aaa44eeeeeeeecaaaaaaaaaeeeeeeeec1111111111111111111111111111111111111111111111111111111111111111111111111111
4aaaaaaaceeeeeee44aaaaaa4eeeeeeeeeaaaaaaaaaeeeeeeeec1111111111111111111111111111111111111111111111111111111111111111111111111111
aaaaaaaaeeeeeeee4aaaaaaa4eeeeeeeeeaaaaaaaaaceeeeeeee1111111111111111111111111111111111111111111111111111111111111111111111111111
aaaaaaaaeeeeeeeeaaaaaaaaaeeeeceeeeaaaaaaaaaceeeeeeee1111111111111111111111111111111111111111111111111111111111111111111111111111
aaa4aaaaeeeeeeeeaaaaaaaaaeeecceeeeaaaa44aaaceeecceee1111111111111111111111111111111111111111111111111111111111111111111111111111
4aa44aa4eeecceeeaaaaaaaaaceecceeec4aaa44aaacceecceec1111111111111111111111111111111111111111111111111111111111111111111111111111
11111111ceecceecaaa44aaa41111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111114aa44aaa41111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
