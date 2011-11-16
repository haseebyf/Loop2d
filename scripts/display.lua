-- ===========================================================
-- Defining the package
-- ===========================================================
display = {
	screenSize = 0, 
	screenWidth = 0, screenHeight = 0,
	screenCenterPoint = {0,0}
}


-- ===========================================================
-- Initialization
-- ===========================================================
function display.initialize()
	display.screenSize = CCDirector:sharedDirector():winSize()
	display.screenWidth = display.screenSize.width
	display.screenWidth = display.screenSize.height
	display.screenCenterPoint = CGPoint(display.screenSize.width / 2, display.screenSize.height / 2)
end