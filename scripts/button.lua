button = lua.class( {
						onPress = nil,
						onRelease = nil,
						onCancel = nil,
					}, sprite)



-- ===========================================================
-- Initialization
-- ===========================================================
function button:__init(aRect)
	print("button:__init() : START")
	local aButton = PLButtonHelper:buttonWithFrame(CGRect(aRect.x, aRect.y, aRect.width, aRect.height))
	print(table.tostring(aButton))
	local newInstance = lua.rawnew(self, {__cc = aButton})
	newInstance = make_proxy(newInstance, {}, self.getters, self.setters, false)
	aButton.__lp = newInstance
	print("button:__init() : END")
	return newInstance
end


-- ===========================================================
-- Events
-- ===========================================================
function button:onPress() 
	print("button:onPress() : Empty")
end


function button:onRelease() 
	print("button:onRelease() : Empty")
end

function button:onCancel() 
	print("button:onCancel() : Override this function to implement onUpdate")
end


-- ===========================================================
-- Children
-- ===========================================================
function scene:addChild(child, zIndex)
	print("scene:addChild() : START")
	if zIndex ~= nil then
		self.__cc:addChild_z(child.__cc, zIndex)
	else
		self.__cc:addChild(child.__cc)
	end
	print("scene:addChild() : END")
end

-- ===========================================================
-- Timers
-- ===========================================================
function scene:startUpdatingScene()
	self.__cc:schedule(tostring("onUpdate:"))
end


function scene:scheduleTimer(callback)
	print("Scene:scheduleTimer() : START")
	assert(type(callback) == "function", "'scheduleTimer' expects a function")
	assert(false, "FIXME: Scene:scheduleTimer needs to be implemented, at the moment only the onUpdate works as the stepper")
	--self.__cc:schedule(tostring(callProxy))
	print("Scene:scheduleTimer() : END")
end