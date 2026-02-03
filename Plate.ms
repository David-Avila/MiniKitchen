Plate = new Sprite
Plate.type = null
Plate.ingredient = null

dsl.addFSM Plate

Plate.addState "empty"
Plate.addState "burger"
Plate.addState "burger_mustard"
Plate.addState "burger_ketchup"
Plate.addState "burger_ketchup_mustard"

Plate.empty.enter = function(p, o)
	o.ingredient = "burger"
	o.image = dsl.images[o.type + "_empty"]
end function

Plate.burger.enter = function(p, o)
	o.image = dsl.images.plate_burger
	o.ingredient = "burger"
end function

Plate.burger_mustard.enter = function(p, o)
	o.image = dsl.images.plate_burger_mustard
	o.ingredient = "burger_mustard"
end function

Plate.burger_ketchup.enter = function(p, o)
	o.image = dsl.images.plate_burger_ketchup
	o.ingredient = "burger_ketchup"
end function

Plate.burger_ketchup_mustard.enter = function(p, o)
	o.image = dsl.images.plate_burger_ketchup_mustard
	o.ingredient = "burger_ketchup_mustard"
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
		if self.worldBounds.contains([mouse.x, mouse.y]) and not self.inState("empty") then
			done = false
			for c in Clients
				if done then break

				if c.inState("waiting") then
					for o in c.order 
						if o == self.ingredient then
							self.changeState "empty"
							c.order.removeVal o
							c.orderUI.restart c.order
							done = true
							break
						end if
					end for
				end if
			end for
		end if
	end if
	self.updateStates
end function