require "loop2d"
--require "MenuScreen"

--local oo = require "loop.simple"

MenuScene = lua.class({}, scene)

-- ============================================
-- Local vars
-- ============================================
-- ***********************************
--local step = nil;

-- ============================================
-- Initialization
-- ============================================
-- ***********************************
function MenuScene:onEnter()
	print("MenuScene.onEnter: START")	
	-- Setting bg
	local bg = sprite("MenuBg.png")
	bg.position = display.screenCenterPoint
	self:addChild(bg,0)
	-- Setting logo
	local logo = sprite("MenuLogo.png")
	logo.position = display.screenCenterPoint
	logo.y = logo.y + 40
	logo.scaleX = 0.5
	logo.scaleY = 0.5
	self:addChild(logo,2)
	-- Setting rotating gear
	local newGear = sprite("MenuGear.png")
	newGear.position = display.screenCenterPoint
	newGear.y = newGear.y - 90
	self:addChild(newGear,1)
	local step1 = action.complex(1 ,action("RotateBy", 1, {duration=0.7, angle=180}),
									action("ScaleBy", 1, {duration=0.7, scale=0.5}))
	local newAction = action.sequence(0, step1, step1:reverse(), action("CallFunction",1,{onCall = function()  end}))	
	newGear:runAction(newAction)
	--newGear:runAction(action("RotateBy", 0, {duration=2, angle=180}))
	-- Setting the play button
	local playButton = button(CGRect(50,50,50,50))
	playButton.position = newGear.position
	self:addChild(playButton)


	self:startUpdatingScene()
	print("MenuSceneScreen.onEnter: END")
end


-- ============================================
-- Stepping
-- ============================================
function MenuScene:onUpdate(delta)
	--print("MenuScene:onUpdate : delta="..delta)
end


