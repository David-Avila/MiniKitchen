globals.recepies = ["burger", "juice"]
tools = ["skillet"]
holder = ["plate"]

import "Tool"
import "Plate"
import "ItemStorage"
import "Client"
import "Juice"

kit = new Sprite

globals.Tools = []
globals.Plates = []
globals.Clients = []

kit.init = function
	super.init
	SPD.add self

	GFX.clear
	GFX.drawImage dsl.images.table, 0,0, 960, 640

	for i in range(0,2)
		t = Tool.Tool.clone
		t.scale = [1, 0.8]
		t.init 180 + 16 * i, 155 + 64 * i, "skillet", "burger"
		Tools.push t
	end for

	for i in range(0,2)
		p = Plate.Plate.clone
		p.scale = [1, 0.6]
		p.init 300 + 8 * i, 165 + 60 * i, "plate", "burger"
		Plates.push p
	end for

	is = new ItemStorage.IS
	is.init 180, 64, "burger"

	c = Client.c.clone
	c.order = ["burger", "burger", "juice"]
	c.init 480
	Clients.push c

	for i in range(0, 2)
		j = Juice.Juice.clone
		j.init 387 + 94 * i, 48
	end for

end function

kit.update = function
	
end function

start = function
	k = new kit
	k.init
end function
