suit_animations = function(parent)
  local parent_x = parent:x()
  local parent_y = parent:y() 
  local anims = {
    idle = {
      frame_1 = function()
        pset(parent_x,parent_y,14)
      end,
      frames = function(self)
        return { self.frame_1 }
      end,
      speed = 10,
      loop = true,
    },
    selected = {
      frame_1 = function()
        pset(parent_x,parent_y,11)
      end,
      frame_2 = function()
        pset(parent_x,parent_y,12)
      end,
      frames = function(self)
        return { self.frame_1, self.frame_2 }
      end,
      speed = 5,
      loop = true,
    }
  }

  return anims
end