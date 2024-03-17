function create_gamepad(context,dealer)
  local gamepad = {
  	context = context,
    disabled = false,
  	update = function(self)
      if self.disabled then return end

      if btnp(⬅️) then
        dealer:set_state('deal_deck')
        context:set_state('arrange')
        self.disabled = true
      elseif btnp(4) then
        local card = context.top_cards[1]
        card:set_state('flip')
      elseif btnp(5) then
        dealer:set_state('deal_hero')
        self.disabled = true
      end
  	end
  }

  return gamepad
end