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

	for i in range(0,game.toolLvl-1)
		t = Tool.Tool.clone
		t.lvl = game.toolLvl
		t.scale = [1, 0.8]
		t.init 180 + 16 * i, 155 + 64 * i, "skillet", "burger", "first"
		FirstTools.push t
	end for

	for i in range(0,game.plateLvl-1)
		p = Plate.Plate.clone
		p.scale = [1, 0.6]
		p.lvl = game.plateLvl
		p.init 300 + 8 * i, 165 + 60 * i, "plate", "burger"
		FirstPlates.push p
	end for

	is = new ItemStorage.IS
	is.init 180, 64, "burger", "first"


	for i in range(0,game.knifeLvl-1)
		t = Tool.Tool.clone
		t.lvl = game.knifeLvl
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

	for i in range(0, game.juiceLvl-1)
		j = Juice.Juice.clone
		j.lvl = game.juiceLvl
		j.init 387 + 94 * i, 48
	end for

	self.clients = 0
	self.idTaken = [0,0,0,0]

	self.spawn = false
	self.startTimer game.spawnTime, "spawn", true
end function

kit.spawnClient = function
	pos = [160, 360, 560, 760]
	
	full = true
	for idx in self.idTaken
		if idx == 0 then
			full = false
			break
		end if
	end for

	if full then return

	while true
		id 	= round(rnd * 3)
		if self.idTaken[id] == 0 then
			self.idTaken[id] = 1
			break
		end if
	end while

	c = Client.c.clone
	c.init pos[id]
	c.id = id
	Clients.push c

	game.kit = self
end function

kit.update = function
	if self.spawn then
		self.spawn = false
		self.startTimer game.spawnTime, "spawn", true
		self.spawnClient
	end if
end function

start = function
	k = new kit
	k.init
end function
