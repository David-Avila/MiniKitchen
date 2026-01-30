ingredients = ["burger"]
tools = ["skillet"]
holder = ["plate"]

import "Tool"
import "Plate"
import "ItemStorage"
import "Client"

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
		t.init 240 + 16 * i, 155 + 64 * i, "skillet", "burger"
		Tools.push t
	end for

	for i in range(0,2)
		p = Plate.Plate.clone
		p.scale = [1, 0.6]
		p.init 380 + 8 * i, 155 + 60 * i, "plate", "burger"
		Plates.push p
	end for

	is = new ItemStorage.IS
	is.init 320, 64, "burger"

	c = Client.c.clone
	c.order = "burger"
	c.init 480
	Clients.push c

end function

kit.update = function

end function

start = function
	k = new kit
	k.init
end function
