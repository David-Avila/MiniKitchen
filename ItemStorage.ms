IS = new Sprite
IS.type = null

IS.init = function(x, y, type)
	self.x = x
	self.y = y
	self.type = type

	self.image = dsl.images[type + "_uncoocked"]
	super.init

	self.localBounds = new Bounds
	self.localBounds.height *= 0.7
	SPD.add self
end function

IS.update = function
	if dsl.keyPressed("mouse 0") then
		if self.worldBounds.contains([mouse.x, mouse.y]) then
			for t in Tools
				if t.inState("empty") and t.ingredient == self.type then
					t.changeState "coocking"
					break
				end if
			end for
		end if
	end if
end function