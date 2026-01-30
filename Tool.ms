
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
	o.currentTime = o.burnTime
	o.image = dsl.images[o.type + "_" + o.ingredient + "_coocked"]
end function

Tool.coocked.update = function(o)
	if o.currentTime <= 0 then
		o.changeState "burned"
	end if

	o.currentTime -= 1
end function

Tool.burned.enter = function(p, o)
	o.image = dsl.images[o.type + "_" + o.ingredient + "_burned"]
end function

Tool.init = function(x,y, type, ingredient)
	self.x = x
	self.y = y
	self.type = type
	self.ingredient = ingredient

	SPD.add self

	self.currentTime = 0
	self.coockTime = 3 * 60
	self.burnTime = 4 * 60

	self.localBounds = new Bounds
	self.localBounds.x += 8
	self.localBounds.y += 8
	self.localBounds.height *= 0.7
	self.localBounds.width *= 0.7

	super.init
	self.changeState "empty"
end function

Tool.update = function
	if dsl.keyPressed("mouse 0") then
		if self.worldBounds.contains([mouse.x, mouse.y]) and self.inState("coocked") then
			self.changeState "empty"
			for p in Plates
				if p.inState("empty") and p.ingredient == self.ingredient then
					p.changeState "full"
					self.changeState "empty"
					break
				end if
			end for
		end if
	end if
	self.updateStates
end function