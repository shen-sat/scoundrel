function draw_card(x,y,facedown)
	x1 = x + 21
	y1 = y + 31

	rectfill(x,y,x1,y1,6)
	pset(x,y,1)
	pset(x,y1,1)
	pset(x1,y,1)
	pset(x1,y1,1)

	if facedown then
	  rectfill(x + 2, y + 2, x1 - 2, y1 - 2, 1)
	end
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

function is_in_table(table, item)
  for value in all(table) do
    if value == item then
      return true
    end
  end

  return false
end

function draw_sspr(x, y, x1, y1, pos_x, pos_y, flip)
  local width = (x1 - x) + 1
  local height = (y1 - y) + 1

  sspr(x, y, width, height, pos_x, pos_y)
end
