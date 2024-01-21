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
      local frame_index = get_frame_index(self,current_time)
      
      if frame_index == self.frame_index then return end

      if frame_index > #self:animations()[self.state]:frames() then
        if self.state == 'flip' then self.facedown = (not self.facedown) end
        
        self:set_state('idle')

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
      self.state_change_time = current_time

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
          loop = true,
        },
        flip = {
          frame_1 = function()
            rectfill(parent_x + 4,parent_y - 3,parent_x + (109 - 92),parent_y + (62 - 34),7)
            rectfill(parent_x + (97 - 92),parent_y - 1,parent_x + (108 - 92),parent_y + (60 - 34),1)
          end,
          frame_2 = function()
            rectfill(parent_x + (102 - 92),parent_y - 6,parent_x + (103 - 92),parent_y + (59 - 34),7)
          end,
          frame_3 = function()
            rectfill(parent_x + 4,parent_y - 3,parent_x + (109 - 92),parent_y + (62 - 34),7)
          end,
          frames = function(self)
            return { self.frame_1, self.frame_2, self.frame_3 }
          end,
          speed = 3,
          loop = false,
        }
      }

      return anims
    end
  }

  return card
end

function get_frame_index(caller,current_time)
  local animation = caller:animations()[caller.state]
  local animation_start_time = caller.state_change_time

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