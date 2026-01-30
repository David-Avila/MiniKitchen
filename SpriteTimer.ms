import "listUtil"

Sprite._timers = null
Sprite.startTimer = function(duration, prop, value=null)
	t = new {}
	t.time = time + duration
	t.prop = prop
	t.value = value
	self._timers.push t
end function

Sprite.init = function
	self._timers = []
end function

Sprite.stopTimer = function(prop="")
	if prop == "" then
		while self._timers.len > 0
			self._timers.removeVal self._timers.removeVal[0]
		end while
	else
		for t in self._timers
			if t.prop == prop then
				self._timers.removeVal t
				break
			end if
		end for
	end if
end function

Sprite.update = function
end function

Sprite.process = function
	for t in self._timers
		if t.time != null then
			if time >= t.time then
				self[t.prop] = t.value
				t.time = null
				self._timers.removeVal t
			end if
		else
			self._timers.removeVal t
		end if
	end for
	
	self.update
end function