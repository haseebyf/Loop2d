require "PropertyHelper"
-- ===========================================================
-- Defining the package
-- ===========================================================
videoPlayer = lua.class{}


-- ===========================================================
-- Initialization
-- ===========================================================
function videoPlayer.playVideo(self, filename)
	if videoPlayer.player == nil then
		print("creating new video player")
		videoPlayer.player = PLVideoPlayer:init()
		videoPlayer.player.player = self
	end
	videoPlayer.player:playVideo(filename)
end


-- ===========================================================
-- Events
-- ===========================================================
function videoPlayer.onMovieStartedPlaying() 
	print("videoPlayer.onMovieStartedPlaying() : Empty")
end


function videoPlayer.onMoviePlaybackFinished()
	print("videoPlayer.onMoviePlaybackFinished() : Empty")
end


-- ===========================================================
-- status
-- ===========================================================
