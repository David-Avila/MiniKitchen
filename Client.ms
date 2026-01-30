import "Order"

c = new Sprite

dsl.addFSM c

c.image = dsl.images.placeholder_client
c.addState "enter"
c.addState "waiting"
c.addState "exit"

c.enter.enter = function(p,o)
	// Generate order
	items = 0

	r = rnd

	if r < 0.33 then
		items = 1
	else if r < 0.7 then
		items = 2
	else
		items = 3
	end if

	o.order = []
	for i in range(0, items-1)
		o.order.push recepies[round(rnd)]
	end for
end function

c.enter.update = function(o)
	o.x = lerp(o.x, o.tx, 2 * dsl.dt)

	if abs(o.x - o.tx) < 2 then
		o.x = o.tx
		o.changeState "waiting"
	end if
end function

c.waiting.enter = function(p,o)
	o.orderUI.init o.x, o.y, o.order
end function
c.waiting.update = function(o)
	if o.order.len == 0 then
		o.changeState "exit"
	end if
end function
c.waiting.exit = function(n, o)
	o.orderUI.image = null
end function

c.exit.update = function(o)
	o.x = lerp(o.x, -200, 2 * dsl.dt)

	if o.x < -180 then
		TXT.clear
		o.changeState "enter"
	end if
end function

c.init = function(x)
	if rnd < 0.5 then self.x = -200 else self.x = 1160
	self.y = 380

	self.tx = x
	self.order = []
	self.orderUI = new Order.Order

	super.init
	BKD.add self
	self.changeState "enter"
end function

c.update = function
	self.orderUI.x = self.x + 100
	self.orderUI.y = self.y + 48

	self.updateStates
end function