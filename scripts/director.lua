director = lua.class{}

function director.showScene(scene,params)
	if(scene ~= nil) then
		-- Show the scene
		if CCDirector:sharedDirector():runningScene() ~= nil then
			-- Scene needs to be replaced, with(out) transition
			if(params ~= nil) then
				assert(params.transition ~= nil, "'transition' not specified")
				if (params.transition == "FadeIn") then
					assert(params.duration ~= nil, "mandatory field 'duration' not specified for transition 'FadeIn'")
					CCDirector:sharedDirector():replaceScene(CCTransitionFade:transitionWithDuration_scene(params.duration, scene.__cc))
					-- [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:10 scene: withColor:]
				end			
			else
				CCDirector:sharedDirector():replaceScene(scene.__cc)
			end
		else
			-- It is the first scene, show right away
			CCDirector:sharedDirector():runWithScene(scene.__cc);
		end
	else
		print("scene should not be nil")
	end
end