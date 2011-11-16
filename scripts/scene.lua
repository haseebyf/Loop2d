require "PropertyHelper"
-- ===========================================================
-- Defining the package
-- ===========================================================
scene = lua.class({__cc = nil}, node)
 

-- ===========================================================
-- Initialization
-- ===========================================================
function scene:__init()
	--print("scene:__init() : START")
	local aScene = PLScene:node()
	local newInstance = lua.rawnew(self, {__cc = aScene})
	aScene.scene = newInstance
	--print("scene:__init() : END")
	return newInstance
	
	--local newInstance = make_proxy(scene, {}, getters, setters, false)
	--local aScene = PLScene:node()
	--newInstance.__cc = aScene
	--newInstance.__cc.scene = newInstance
	--return newInstance;
end


-- ===========================================================
-- Events
-- ===========================================================
function scene:onEnter() 
	--print("scene:onEnter() : Empty")
end

function scene:onExit() 
	--print("scene:onExit() : Empty")
end

function scene:onUpdate() 
	print("Scene:onUpdate() : Override this function to implement onUpdate")
end


-- ===========================================================
-- Children
-- ===========================================================
function scene:addChild(child, zIndex)
	--print("scene:addChild() : START")
	if zIndex ~= nil then
		self.__cc:addChild_z(child.__cc, zIndex)
	else
		self.__cc:addChild(child.__cc)
	end
	--print("scene:addChild() : END")
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