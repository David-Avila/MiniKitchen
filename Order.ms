buffer = new PixelDisplay

Order = new Sprite
Order.order = null

Order.init = function(x, y, order)
	self.updateOrder order

	super.init
	BKD.add self
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