require "loop2d"



local scene =  HelloWorldLayer:scene()
director.showScene(scene);

local background = sprite:new("Default.png")

background.x = 300
background.y = 300

scene:addChild(background.__cc);
