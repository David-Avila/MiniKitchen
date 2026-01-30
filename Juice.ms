Juice = new Sprite
Juice.type = null
Juice.ingredient = null

dsl.addFSM Juice

Juice.addState "empty"
Juice.addState "full"

Juice.empty.enter = function(p, o)
	o.image = dsl.images.juice_empty
	self.fullTime = 3 * 60
end function

Juice.empty.update = function(o)
	if self.fullTime <= 0 then
		o.changeState "full"
	else
		self.fullTime -= 1
	end if
end function

Juice.full.enter = function(p, o)
	o.image = dsl.images.juice_full
end function

Juice.init = function(x,y)
	self.x = x
	self.y = y

	self.localBounds = new Bounds
	self.localBounds.height *= 0.8
	self.localBounds.width *= 0.8

	SPD.add self

	super.init
	self.changeState "empty"
end function

Juice.update = function
	if dsl.keyPressed("mouse 0") then
		if self.worldBounds.contains([mouse.x, mouse.y]) and self.inState("full") then
			for c in Clients
				if c.inState("waiting") then
					for o in c.order 
						if o == "juice" then
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