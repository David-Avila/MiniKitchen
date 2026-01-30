c = new Sprite
c.order = null

dsl.addFSM c

c.addState "enter"
c.addState "waiting"
c.addState "exit"

c.enter.enter = function(p,o)
end function
c.enter.update = function(o)
	o.x = lerp(o.x, o.tx, 2 * dsl.dt)

	if abs(o.x - o.tx) < 2 then
		o.x = o.tx
		o.changeState "waiting"
	end if
end function

c.waiting.enter = function(p,o)
	print "I want a burger"
end function
c.waiting.update = function(o)
	if o.order.len == 0 then
		o.changeState "exit"
	end if
end function
c.waiting.exit = function(n, o)
	print "Thanks!"
end function

c.exit.enter = function(p,o)
end function
c.exit.update = function(o)
	o.x = lerp(o.x, -200, 2 * dsl.dt)
end function

c.init = function(x)
	if rnd < 0.5 then self.x = -200 else self.x = 1160
	self.y = 320

	self.image = dsl.images.placeholder_client

	self.tx = x

	super.init
	BKD.add self
	self.changeState "enter"
end function

c.update = function
	self.updateStates
end function