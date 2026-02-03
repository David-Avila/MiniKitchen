clear
import "DSL"
import "mathUtil"
globals.lerp = @mathUtil.lerp


dsl.importImages
dsl.importSounds

import "SpriteTimer"
import "Kitchen"

game = new Sprite
game.kit = null
game.toolLvl 	= 3
game.plateLvl 	= 3
game.knifeLvl 	= 3
game.juiceLvl 	= 3

game.spawnTime = 4

// Level variables
game.maxOrders = 3
game.clients = 5

dsl.addFSM game

game.addState "menu"
game.addState "kitchen"

game.menu.update = function(o)

end function

game.kitchen.enter = function(p,o)
	SPD.wipe
	Kitchen.start
end function

game.kitchen.update = function(o)
	TRD.clear

	for sp in SPD.sprites
		sp.process
	end for
	
	for sp in UID.sprites
		sp.process
	end for
end function

game.init = function
	super.init

	self.changeState "kitchen"
end function

game.update = function
	self.updateStates
end function

GFX.clear "#18202f"
game.init
while dsl.running
	dsl.update

	if dsl.keyPressed("escape") then
		dsl.stop
	end if
	
	game.process

	yield
end while

SPD.wipe
BKD.wipe
UID.wipe
TRD.clear