-- Helpers
require "PropertyHelper"
require "language"

-- Base


-- Logic
require "action"
require "sprite"
require "scene"
require "director"
require "display"
require "videoPlayer"

-- widget
require "button"



loop2d = lua.class{version = 0.1}

function loop2d:initEngine()
	-- Initialize display
	display.initialize()
end