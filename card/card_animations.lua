card_animations = function(parent)
  local parent_x = parent.x
  local parent_y = parent.y
  local parent_facedown = parent.facedown
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
      frames = function(parent)
        return { parent.frame_1 }
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
      frames = function(parent)
        return { parent.frame_1, parent.frame_2, parent.frame_3 }
      end,
      speed = 3,
      loop = false,
    }
  }

  return anims
end