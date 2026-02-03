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

	if r < 0.4 then
		items = 1
	else if r < 0.8 then
		items = 2
	else
		items = 3
	end if

	if items > game.maxOrders then items = game.maxOrders

	o.order = []
	for i in range(0, items-1)
		o.order.push recipes[round(rnd*(recipes.len-1))]
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
	o.orderUI.restart o.order
end function
c.waiting.update = function(o)
	o.orderUI.update

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
		game.kit.idTaken[o.id] = 0
		UID.remove o
	end if
end function

c.init = function(x)
	if rnd < 0.5 then self.x = -200 else self.x = 1160
	
	self.y = 380
	self.id = null

	self.tx = x
	self.order = []

	self.greenTime = 15 * 60
	self.yellowTime = 5 * 60
	self.redTime = 5 * 60

	self.orderUI = new Order.Order
	self.orderUI.init self.x, self.y, [15, 5, 5]
	self.orderUI.client = self

	super.init
	UID.add self
	self.changeState "enter"
end function

c.update = function
	self.orderUI.x = self.x + 100
	self.orderUI.y = self.y + 48

	self.updateStates
end function