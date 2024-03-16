function create_gamepad(deck,context)
  local gamepad = {
  	context = context,
    deck = deck,
    disabled = false,
  	update = function(self)
      if self.disabled then return end
      gamepad_debug = 'enabled'

      if btnp(⬅️) then
        deck:set_state('deal')
        context:set_state('deal')
        self.disabled = true
      elseif btnp(4) then
        local card = context.top_cards[1]
        card:set_state('flip')
      end
  	end
  }

  return gamepad
end