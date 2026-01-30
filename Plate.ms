Plate = new Sprite
Plate.type = null
Plate.ingredient = null

dsl.addFSM Plate

Plate.addState "empty"
Plate.addState "full"

Plate.empty.enter = function(p, o)
	o.image = dsl.images[o.type + "_empty"]
end function

Plate.full.enter = function(p, o)
	o.image = dsl.images[o.type + "_" + o.ingredient]
end function

Plate.init = function(x,y, type, ingredient)
	self.x = x
	self.y = y
	self.type = type
	self.ingredient = ingredient

	self.localBounds = new Bounds
	self.localBounds.height *= 0.8
	self.localBounds.width *= 0.8

	SPD.add self

	super.init
	self.changeState "empty"
end function

Plate.update = function
	if dsl.keyPressed("mouse 0") then
		if self.worldBounds.contains([mouse.x, mouse.y]) and self.inState("full") then
			for c in Clients
				if c.inState("waiting") then
					for o in c.order 
						if o == self.ingredient then
							self.changeState "empty"
							c.order.removeVal o
							c.orderUI.updateOrder c.order
							break
						end if
					end for
				end if
			end for
		end if
	end if
	self.updateStates
end function