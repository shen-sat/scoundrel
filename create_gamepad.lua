function create_gamepad(context,dealer)
  -- 0 left
  -- 1 right
  -- 2 up
  -- 3 down
  -- 4 z
  -- 5 x
  local gamepad = {
  	context = context,
    disabled = false,
  	update = function(self)
      if self.disabled then return end

      if btnp(0) then
        if not context:is_complete() then return end
        
        cursor:set_state('left')
        self.disabled = true
      elseif btnp(1) then
        if not context:is_complete() then return end
        
        cursor:set_state('right')
        self.disabled = true
      elseif btnp(4) then
        dealer:set_state('deal_deck')
        self.disabled = true
      elseif btnp(5) then
        dealer:set_state('deal_hero')
        self.disabled = true
        -- dealer:set_state('deal_torch')
        -- self.disabled = true
      end
  	end
  }

  return gamepad
end