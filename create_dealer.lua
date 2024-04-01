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
        -- deal cards from deck to context
        if not self.context:is_full() then
          local dealt_card = self.deck[1]
          if dealt_card.y + move_speed < self.context.top_row.y then
            dealt_card.y += move_speed
          else
            dealt_card.y = self.context.top_row.y
            del(self.deck, dealt_card)
            add(self.context.top_cards, dealt_card)
          end
        end
        -- arrange cards already present in context
        for i=1, #self.context.top_cards do
          local card = self.context.top_cards[i]
          local card_x = card.x + self.context.move_speed
          local var = #self.context.top_row.x_points + 1

          if card_x > self.context.top_row.x_points[var - i] then
            card.x = self.context.top_row.x_points[var - i]
            if card.facedown then card:set_state('flip') end
          else
            card.x += self.context.move_speed
          end
        end

        if self.context:is_complete() then 
          self:set_state('idle')
          self.gamepad.disabled = false
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
      assert(not is_in_table(self.context.bottom_cards, card), "card:"..card.suit.type.." is already in context! " )

      local target_y = target_y
      if card.y - move_speed > target_y then
        card.y -= move_speed
      else
        card.y = target_y
        card:set_state('flip')
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