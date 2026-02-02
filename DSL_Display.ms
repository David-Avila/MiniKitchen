// Display Managment
import "listUtil"

if not globals.hasIndex("dsl") then
	globals.dsl = {}
end if

dsl.disp = {}

display(6).mode = displayMode.sprite
display(2).mode = displayMode.sprite
display(1).mode = displayMode.pixel
display(0).mode = displayMode.sprite

// Default displays
globals.SOL = display(7) // Solid
globals.UID = display(6)
globals.GFX = display(5) // Pixel
globals.SPD = display(4) // Sprite
globals.TXT = display(3) // Text
globals.BKD = display(2) // UI
globals.TRD = display(1) // Transitions
globals.TOD = display(0) // Top display

TRD.clear

// Helper functions
SPD.add = function(sprite)
	SPD.sprites.push sprite
end function

SPD.remove = function(sprite)
	SPD.sprites.removeVal sprite
end function

SPD.wipe = function
	while SPD.sprites.len > 0
		SPD.remove SPD.sprites[0]
	end while
end function

// Helper functions
UID.add = function(sprite)
	UID.sprites.push sprite
end function

UID.remove = function(sprite)
	UID.sprites.removeVal sprite
end function

UID.wipe = function
	while UID.sprites.len > 0
		UID.remove UID.sprites[0]
	end while
end function

// Helper functions
BKD.add = function(sprite)
	BKD.sprites.push sprite
end function

BKD.remove = function(sprite)
	BKD.sprites.removeVal sprite
end function

BKD.wipe = function
	while BKD.sprites.len > 0
		BKD.remove BKD.sprites[0]
	end while
end function