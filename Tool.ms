
Tool = new Sprite
Tool.type = null
Tool.ingredient = null
Tool.kit = null

dsl.addFSM Tool

Tool.addState "empty"
Tool.addState "coocking"
Tool.addState "coocked"
Tool.addState "burned"

Tool.empty.enter = function(p, o)
	o.image = dsl.images[o.type + "_empty"]
	o.currentTime = 0
end function

Tool.coocking.enter = function(p, o)
	o.currentTime = o.coockTime
	o.image = dsl.images[o.type + "_" + o.ingredient + "_uncoocked"]
end function

Tool.coocking.update = function(o)
	if o.currentTime <= 0 then
		o.changeState "coocked"
	end if

	o.currentTime -= 1
end function

Tool.coocked.enter = function(p, o)
	if o.type == "mustard" then
		o.image = dsl.images.mustard
	else if o.type == "ketchup" then
		o.image = dsl.images.ketchup
	else
		o.currentTime = o.burnTime
		o.image = dsl.images[o.type + "_" + o.ingredient + "_coocked"]
	end if
end function

Tool.coocked.update = function(o)
	if o.currentTime <= 0 and (o.type != "knife" and o.type != "mustard" and o.type != "ketchup") then
		o.changeState "burned"
	end if

	o.currentTime -= 1
end function

Tool.burned.enter = function(p, o)
	o.image = dsl.images[o.type + "_" + o.ingredient + "_burned"]
end function

Tool.init = function(x,y, type, ingredient="", id="")
	self.x = x
	self.y = y
	self.type = type
	self.ingredient = ingredient

	self.id = id

	SPD.add self

	self.currentTime = 0
	self.coockTime = 4 * 60
	self.burnTime = 15 * 60

	self.localBounds = new Bounds
	self.localBounds.x += 8
	self.localBounds.y += 8
	self.localBounds.height *= 0.7
	self.localBounds.width *= 0.7

	super.init

	if self.type == "mustard" or self.type == "ketchup" then
		self.changeState "coocked"
	else
		self.changeState "empty"
	end if
end function

Tool.update = function
	if dsl.keyPressed("mouse 0") then
		if self.worldBounds.contains([mouse.x, mouse.y]) and self.inState("coocked") then

			if self.type == "mustard" then
				for p in FirstPlates
					if p.inState("burger") then
						p.changeState "burger_mustard"
						break
					else if p.inState("burger_ketchup") then
						p.changeState "burger_ketchup_mustard"
						break
					end if
				end for
				return
			else if self.type == "ketchup" then
				for p in FirstPlates
					if p.inState("burger") then
						p.changeState "burger_ketchup"
						break
					else if p.inState("burger_mustard") then
						p.changeState "burger_ketchup_mustard"
						break
					end if
				end for
				return
			end if

			if self.id == "first" then
				for p in FirstPlates
					if p.inState("empty") and p.ingredient == self.ingredient then
						p.changeState self.ingredient
						self.changeState "empty"
						break
					end if
				end for
			else if self.type == "knife" then
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
	end if
	self.updateStates
end function