function create_dealer(deck,hero,torch,context)
  local dealer = {
  	context = context,
    state = 'idle',
    deck = deck,
    hero = hero,
    torch = torch,
  	update = function(self)
      local move_speed = context.move_speed

      if self.state == 'deal_deck' then
        if not self.context:is_full() then
          local dealt_card = self.deck[1]
          if dealt_card.y + move_speed < self.context.top_row.y then
            dealt_card.y += move_speed
          else
            dealt_card.y = self.context.top_row.y
            del(self.deck, dealt_card)
            add(self.context.top_cards, dealt_card)
            if self.context:is_full() then self:set_state('idle') end
          end
        end
  		elseif self.state == 'deal_hero' then
        local card = self.hero
        local target_y = context:hero_slot().y
        self:deal_card(card, target_y)
      elseif self.state == 'deal_torch' then
        local card = self.torch
        local target_y = context:torch_slot().y
        self:deal_card(card, target_y)
      end
  	end,
    deal_card = function(self, card, target_y)
      local card = card
      local target_y = target_y

      if card.y - move_speed > target_y then
        card.y -= move_speed
      else
        card.y = target_y
        card:set_state('flip')
        card = nil
        add(self.context.bottom_cards, card)
        self:set_state('idle')
        self.gamepad.disabled = false
      end
    end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return dealer
end