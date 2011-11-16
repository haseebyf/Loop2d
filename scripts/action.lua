action = lua.class{__cc = nil,
				actionType = nil,
				repeatCount = 0
						}
						
function action:__init(anActionType, repeatCount, params)
	--print("action:__init() : START")
	-- Creating the base action
	assert(anActionType ~= nil, "'actionType' cannot be nil")
	aBaseAction = lua.switch(anActionType):caseof{
		["RotateBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.angle ~= nil, "'angle' is required for action "..x)

							return CCRotateBy:actionWithDuration_angle(params.duration, params.angle)
						end,
		["RotateTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.angle ~= nil, "'angle' is required for action "..x)

							return CCRotateTo:actionWithDuration_angle(params.duration, params.angle)
						end,
		["MoveTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.point ~= nil, "'point' is required for action "..x)
							return CCMoveTo:actionWithDuration_position(params.duration, CGPoint(params.point.x, params.point.y))
						end,
		["MoveBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.point ~= nil, "'point' is required for action "..x)
							return CCMoveBy:actionWithDuration_position(params.duration, CGPoint(params.point.x, params.point.y))
						end,
		["SkewTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.skewX ~= nil, "'skewX' is required for action "..x)
							assert(params.skewY ~= nil, "'skewY' is required for action "..x)

							return CCSkewTo:actionWithDuration_skewX_skewY(params.duration, params.skewX, params.skewY)
						end,
		["SkewBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.skewX ~= nil, "'skewX' is required for action "..x)
							assert(params.skewY ~= nil, "'skewY' is required for action "..x)

							return CCSkewBy:actionWithDuration_skewX_skewY(params.duration, params.skewX, params.skewY)
						end,
		["JumpBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.point ~= nil, "'point' is required for action "..x)
							assert(params.height ~= nil, "'height' is required for action "..x)
							assert(params.jumps ~= nil, "'jumps' is required for action "..x)

							return CCJumpBy:actionWithDuration_position_height_jumps(params.duration, CGPoint(params.point.x, params.point.y), params.height, params.jumps)
						end,
		["JumpTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.point ~= nil, "'point' is required for action "..x)
							assert(params.height ~= nil, "'height' is required for action "..x)
							assert(params.jumps ~= nil, "'jumps' is required for action "..x)

							return CCJumpTo:actionWithDuration_position_height_jumps(params.duration, CGPoint(params.point.x, params.point.y), params.height, params.jumps)
						end,
		["BezierBy"] =	function (x)
							assert(false, "FIXME: NOT IMPLEMENTED "..x)
						end,
		["BezierTo"] =	function (x) 
							assert(false, "FIXME: NOT IMPLEMENTED "..x)
						end,
		["ScaleTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.scale ~= nil, "'scale' is required for action "..x)

							return CCScaleTo:actionWithDuration_scale(params.duration, params.scale)
						end,
		["ScaleBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.scale ~= nil, "'scale' is required for action "..x)

							return CCScaleBy:actionWithDuration_scale(params.duration, params.scale)
						end,
		["Blink"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.blinks ~= nil, "'blinks' is required for action "..x)

							return CCBlink:actionWithDuration_blinks(params.duration, params.blinks)
						end,
		["FadeIn"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							return CCFadeIn:actionWithDuration(params.duration)
						end,
		["FadeOut"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							return CCFadeOut:actionWithDuration(params.duration)
						end,
		["FadeTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.opacity ~= nil, "'opacity' is required for action "..x)

							return CCFadeTo:actionWithDuration_opacity(params.duration, params.opacity)
						end,
		["TintTo"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.r ~= nil, "'r' is required for action "..x)
							assert(params.g ~= nil, "'g' is required for action "..x)
							assert(params.b ~= nil, "'b' is required for action "..x)

							return CCTintTo:actionWithDuration_red_green_blue(params.duration, params.r, params.g, params.b)
						end,
		["TintBy"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							assert(params.r ~= nil, "'r' is required for action "..x)
							assert(params.g ~= nil, "'g' is required for action "..x)
							assert(params.b ~= nil, "'b' is required for action "..x)

							return CCTintBy:actionWithDuration_red_green_blue(params.duration, params.r, params.g, params.b)
						end,
		["DelayTime"] =	function (x) 
							assert(params.duration ~= nil, "'duration' is required for action "..x)
							return CCDelayTime:actionWithDuration(params.duration)
						end,
		["CallFunction"] =	function (x) 
							assert(params.onCall ~= nil, "'onCall' is required for action "..x)
							return PLCallFuncHelper:init():prepareAction(params.onCall)
							--return CCCallFuncND:actionWithTarget_selector_data(params.function)
						end,
			 default = function (x) 
							assert(false, "Invalid action "..x)
					   end,
			 missing = function (x) 
							assert(false, "Invalid action "..x)
					   end,
	}
	-- Create the repeatition wrapper
	local anAction = aBaseAction
	if (repeatCount < 1) then
		anAction = CCRepeatForever:actionWithAction(aBaseAction)
	elseif (repeatCount > 1) then
		anAction = CCRepeat:actionWithAction_times(aBaseAction, repeatCount)
	end
	
	local newInstance = lua.rawnew(self, {__cc = anAction, repeatCount = repeatCount})
	newInstance.action = newInstance
	--print("action:__init() : END")
	return newInstance
end


function action:reverse()
	--assert(false, "FIXME: NOT IMPLEMENTED "..x)
	local aBaseAction = action("DelayTime", 1, {duration=0})
	--print(unpack(actionList))
	aBaseAction.__cc = self.__cc:reverse()
	return aBaseAction
end


function action.sequence(repeatCount, ...)
	--print("action.sequence() : END")
	local actionList = {}
	for i,v in ipairs(arg) do
		assert(v.repeatCount > 0, "Sequence cannot contain an action with infinit repeatCount (repetitions = 0)")
		print(v.repeatCount)
		table.insert(actionList, v.__cc)
	end
	
	local aBaseAction = action("DelayTime", 1, {duration=0})
	--print(unpack(actionList))
	aBaseAction.__cc = CCSequence:actionsWithArray(actionList)
	-- Create the repeatition wrapper
	local anAction = aBaseAction
	if (repeatCount < 1) then
		anAction.__cc = CCRepeatForever:actionWithAction(aBaseAction.__cc)
	elseif (repeatCount > 1) then
		anAction._cc = CCRepeat:actionWithAction_times(aBaseAction.__cc, repeatCount)
	end
	anAction.repeatCount = repeatCount
	--print("action.sequence() : END")
	return anAction
end


function action.complex(repeatCount, ...)
	--print("action.sequence() : END")
	local actionList = {}
	for i,v in ipairs(arg) do
		assert(v.repeatCount > 0, "Sequence cannot contain an action with infinit repeatCount (repetitions = 0)")
		print(v.repeatCount)
		table.insert(actionList, v.__cc)
	end
	
	local aBaseAction = action("DelayTime", 1, {duration=0})
	--print(unpack(actionList))
	aBaseAction.__cc = CCSpawn:actionsWithArray(actionList)
	-- Create the repeatition wrapper
	local anAction = aBaseAction
	if (repeatCount < 1) then
		anAction.__cc = CCRepeatForever:actionWithAction(aBaseAction.__cc)
	elseif (repeatCount > 1) then
		anAction._cc = CCRepeat:actionWithAction_times(aBaseAction.__cc, repeatCount)
	end
	anAction.repeatCount = repeatCount
	--print("action.sequence() : END")
	return anAction
end