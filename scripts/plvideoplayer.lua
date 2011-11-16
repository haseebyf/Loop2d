waxClass{"PLVideoPlayer", NSObject}

-- ***************************************************
function init(self)
	self = self.super:init()
	self.isPlayingVideo = false
	return self
end


function playVideo(self, video) 
	print(self)
	CCVideoPlayer:setDelegate(self)
	CCVideoPlayer:playMovieWithFile(video)
	self.isPlayingVideo = false
end





function moviePlaybackFinished(self)
	self.isPlayingVideo = false
	CCDirector:sharedDirector():startAnimation()
	if self.player.onMoviePlaybackFinished ~= nil then
		self.player.onMoviePlaybackFinished()
	end
end


function movieStartsPlaying(self)
	self.isPlayingVideo = true
	CCDirector:sharedDirector():stopAnimation()
	if self.player.onMovieStartedPlaying ~= nil then
		self.player.onMovieStartedPlaying()
	end
end