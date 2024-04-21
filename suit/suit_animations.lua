suit_animations = function(parent)
  local parent_x = parent:x()
  local parent_y = parent:y() 
  local anims = {
    idle = {
      frames = function(self)
        return { 
          function()
            pset(parent_x,parent_y,14)
          end
        }
      end,
      speed = 10,
      loop = true,
    },
    selected = {
      frames = function(self)
        return {
          function()
            pset(parent_x,parent_y,11)
          end,
          function()
            pset(parent_x,parent_y,12)
          end,
        }
      end,
      speed = 5,
      loop = true,
    }
  }

  return anims
end