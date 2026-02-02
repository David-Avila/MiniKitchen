buffer = new PixelDisplay

Order = new Sprite
Order.order = null

Order.init = function(x, y, times)

	self.greenTime 	= times[0]
	self.yellowTime = times[1]
	self.redTime 	= times[2]

	self.client = null
	self.totalTime = times[0] + times[1] + times[2]

	self.remainingTime = self.totalTime
	self.targetTime =  time + self.totalTime

	self.percent = 1

	self.colors = ["#50ff50", "#ffff50", "#ff5050"]
	self.colorId = 0

	super.init
	BKD.add self
end function

Order.restart = function(order)
	self.updateOrder order

	self.percent = 1
	self.colorId = 0

	self.remainingTime = self.totalTime
	self.targetTime =  time + self.totalTime
end function

Order.update = function
	self.remainingTime -= dsl.dt
	self.percent = self.remainingTime / self.targetTime

	if self.percent > 0 then
		if self.percent < 0.2 then
			self.colorId = 2
		else if self.percent < 0.4 then
			self.colorId = 1
		else
			self.colorId = 0
		end if

		TRD.fillRect self.x - 32, self.y - 94, 19, 187 * self.percent, self.colors[self.colorId]
	else if not self.client.inState("exit") then
		self.client.changeState "exit"
	end if
end function

Order.updateOrder = function(order)
	self.image = null
	
	buffer.clear
	buffer.drawImage dsl.images.order_background, 0, 0

	i = 0
	for o in order
		buffer.drawImage dsl.images[o], 90-32, 140 - 66 * i
		i += 1
	end for

	self.image = buffer.getImage(0, 0, 128, 206)
end function