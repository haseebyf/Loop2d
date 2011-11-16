require "Loop2d"
require "MenuScreen"

--local oo = require "loop.simple"

IntroScene = lua.class({}, scene)

-- ***********************************
function IntroScene:onEnter()
	print("IntroScreen.onEnter: START")
	-- Adding background
	local bg = sprite("Default.png")
	bg.position = display.screenCenterPoint
	bg.rotation = -90
	-- Playing video
	self:addChild(bg,1)
	--print(table.tostring(oo.superclass(self)))
	--print(table.tostring(self))
	--print(self.__cc)

	-- Playing video
	screen  = MenuScene{}
	director.showScene(screen, {transition="FadeIn", duration=0.5})
	
	--videoPlayer.onMoviePlaybackFinished = function()
	--	screen  = MenuScene{}
	--	director.showScene(screen, {transition="FadeIn", duration=1})
	--end
	--videoPlayer:playVideo("intro.mp4")
	print("IntroScreen.onEnter: END")
end