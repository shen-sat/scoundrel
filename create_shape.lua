function create_shape()
	local shape = {
		animation = nil,
		draw = function(self)
			if self.animation then run_animation(self,counter) end
			
			if not self.animation then rectfill(0,0,1,1,7) end
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
	local index = flr((current_counter - animation.start_counter)/animation.speed)

	if animation.loop then
		animation:frames()[(index % #animation:frames()) + 1]()
	else
		if index + 1 > #animation:frames() then
			animation.start_counter = nil
			caller.animation = nil
		else
			animation:frames()[index + 1]()
		end	
	end
end