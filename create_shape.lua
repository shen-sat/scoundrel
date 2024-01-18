function create_shape()
	local shape = {
		animation = nil,
		draw = function(self)

			if self.animation then
				run_animation(self,counter)
			else
				rectfill(0,0,1,1,7)
			end
		end,
		animations = {
			flip = {
				frame_1 = function()
					rectfill(0,0,2,2,7)	
				end,
				frame_2 = function()
					rectfill(0,0,3,3,7)	
				end,
				frame_3 = function()
					rectfill(0,0,4,4,7)
				end,
				frames = function(self)
					return {self.frame_1,self.frame_2,self.frame_3}
				end,
				speed = 10,
				loop = false,
				start_counter = nil
			}
		}
	}

	return shape
end

function run_animation(caller,current_counter)
	local animation = caller.animation

	if not animation.start_counter then
		animation.start_counter = current_counter
	end
	local time_elapsed = current_counter - animation.start_counter
	-- using flr makes sure we alwways return an integer at regular intervals
	-- Eg animation.speed of 3 will return 0,0,0,1,1,1,2,2,2...
	local index = flr(time_elapsed/animation.speed)

	if animation.loop then
		-- if the animation loops, then loop using modulo
		animation:frames()[(index % #animation:frames()) + 1]()
	else
		-- Note an animation_size of eg 30, translates to an index (caluclated above) being from 0 -> 29 inclusive
		local animation_size = #animation:frames() * animation.speed
		if (animation_size - 1) <= (current_counter - animation.start_counter) then
			animation.start_counter = nil
			caller.animation = nil
		end	
		animation:frames()[index + 1]()
	end
end