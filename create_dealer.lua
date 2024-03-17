function create_dealer(deck,hero,context)
  local dealer = {
  	context = context,
    state = 'idle',
    deck = deck,
    hero = hero,
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
        local hero_x = context:hero_slot().x
        local hero_y_target = context:hero_slot().y
        
        if self.hero.y - move_speed > hero_y_target then
          self.hero.y -= move_speed
        else
          self.hero.y = hero_y_target
          self.hero:set_state('flip')
          self.hero = nil
          add(self.context.bottom_cards, hero)
          self:set_state('idle')
          self.gamepad.disabled = false
        end
  		end
  	end,
    set_state = function(self,new_state)
      self.state = new_state
    end
  }

  return dealer
end