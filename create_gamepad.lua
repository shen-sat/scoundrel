function create_gamepad(deck,context,dealer)
  local gamepad = {
  	context = context,
    deck = deck,
    disabled = false,
  	update = function(self)
      if self.disabled then return end
      gamepad_debug = 'enabled'

      if btnp(⬅️) then
        dealer:set_state('deal_deck')
        context:set_state('deal')
        self.disabled = true
      elseif btnp(4) then
        local card = context.top_cards[1]
        card:set_state('flip')
      elseif btnp(5) then
        dealer:set_state('deal_hero')
      end
  	end
  }

  return gamepad
end