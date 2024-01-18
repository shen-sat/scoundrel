function create_shape()
	local shape = {
		x = 0,
		y = 0,
		state = 'idle',
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
			local anims = {
				idle = {
					frame_1 = function()
						rectfill(parent_x,parent_y,1,1,7)
					end,
					frames = function(self)
						return { self.frame_1 }
					end,
					speed = 10,
					loop = true,
				},
				flip = {
					frame_1 = function()
						rectfill(parent_x,parent_y,2,2,7)	
					end,
					frame_2 = function()
						rectfill(parent_x,parent_y,3,3,7)	
					end,
					frame_3 = function()
						rectfill(parent_x,parent_y,4,4,7)
					end,
					frames = function(self)
						return {self.frame_1,self.frame_2,self.frame_3}
					end,
					speed = 10,
					loop = true
				}
			}

			return anims
		end
	}

	return shape
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