director = {}

function director.showScene(scene)
	if(scene ~= nil) then
		-- Show the scene
		if CCDirector:sharedDirector():runningScene() ~= nil then
			-- Scene needs to be replaced, with(out) transition
		else
			-- It is the first scene, show right away
			CCDirector:sharedDirector():runWithScene(scene);
		end
	else
		print("scene should not be nil")
	end
end