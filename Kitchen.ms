globals.recipes = ["burger", "juice", "carrot", "burger_mustard", "burger_ketchup", "burger_ketchup_mustard"]
tools = ["skillet", "knife"]
holder = ["plate"]

import "Tool"
import "Plate"
import "ItemStorage"
import "Client"
import "Juice"

kit = new Sprite

globals.FirstTools = []
globals.FirstPlates = []
globals.SecondTools = []
globals.SecondPlates = []
globals.Clients = []

kit.init = function
	super.init
	SPD.add self

	GFX.clear
	GFX.drawImage dsl.images.table, 0,0, 960, 640

	for i in range(0,game.tools-1)
		t = Tool.Tool.clone
		t.scale = [1, 0.8]
		t.init 180 + 16 * i, 155 + 64 * i, "skillet", "burger", "first"
		FirstTools.push t
	end for

	for i in range(0,game.plates-1)
		p = Plate.Plate.clone
		p.scale = [1, 0.6]
		p.init 300 + 8 * i, 165 + 60 * i, "plate", "burger"
		FirstPlates.push p
	end for

	is = new ItemStorage.IS
	is.init 180, 64, "burger", "first"


	for i in range(0,game.knifes-1)
		t = Tool.Tool.clone
		t.scale = [1, 0.8]
		t.init 700 - 16 * i, 155 + 64 * i, "knife", "carrot", "second"
		SecondTools.push t
	end for

	is = new ItemStorage.IS
	is.init 730, 64, "carrot", "second"

	m = Tool.Tool.clone
	m.scale = [1, 0.8]
	m.init 480, 200, "mustard"

	k = Tool.Tool.clone
	k.scale = [1, 0.8]
	k.init 480, 280, "ketchup"

	c = Client.c.clone
	c.init 480
	Clients.push c

	for i in range(0, game.juices-1)
		j = Juice.Juice.clone
		j.init 387 + 94 * i, 48
	end for

	self.clients = 0

end function

kit.spawnClient = function
	
end function

kit.update = function
	
end function

start = function
	k = new kit
	k.init
end function
