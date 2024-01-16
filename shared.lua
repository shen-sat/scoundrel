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