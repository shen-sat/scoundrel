function create_card(x,y,suit,value)
  local card = {
    suit = suit,
    value = value,
    x = x,
    y = y,
    state = 'idle',
    facedown = true,
    frame_index = 1,
    state_change_time = 0,
    update = function(self)
      local current_animation = self:animations()[self.state]
      local frame_index = get_frame_index(current_animation,self.state_change_time,time)
      
      if frame_index == self.frame_index then return end

      if frame_index > #current_animation:frames() then
        self:set_state()
      else
        self:set_frame_index(frame_index)
      end
    end,
    draw = function(self)
      local frames = self:animations()[self.state]:frames()
      local index = self.frame_index
      
      frames[index]()
    end,
    set_state = function(self,new_state)
      if new_state == self.state then return end

      self.frame_index = 1
      self.state_change_time = time

      if new_state then
        self.state = new_state  
      else
        self.state = 'idle' 
      end
    end,
    set_frame_index = function(self,frame_index)
      self.frame_index = frame_index
    end,
    animations = function(self)
      local parent_x = self.x
      local parent_y = self.y
      local parent_facedown = self.facedown
      local anims = {
        idle = {
          frame_1 = function()
            x1 = parent_x + 21
            y1 = parent_y + 31

            rectfill(parent_x,parent_y,x1,y1,7)
            pset(parent_x,parent_y,1)
            pset(parent_x,y1,1)
            pset(x1,parent_y,1)
            pset(x1,y1,1)

            if parent_facedown then
              rectfill(parent_x + 2, parent_y + 2, x1 - 2, y1 - 2, 1)
            end
          end,
          frames = function(self)
            return { self.frame_1 }
          end,
          speed = 10,
          loop = false,
        }
      }

      return anims
    end
  }

  return card
end

function get_frame_index(animation,animation_start_time,current_time)

  local time_elapsed = current_time - animation_start_time
  -- using flr makes sure we alwways return an integer at regular intervals
  -- Eg animation.speed of 3 will return 0,0,0,1,1,1,2,2,2...
  local i = flr(time_elapsed/animation.speed)

  if animation.loop then
    local frames = animation:frames()
    return (i % #frames) + 1
  else
    return i + 1
  end
end