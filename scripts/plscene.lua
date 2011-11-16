waxClass{"PLScene", PLLayer}

-- ***************************************************
function init(self)
	--print("PLScene:Init() : START");
	self = self.super:init()
	self.scene = nil
	--print("PLScene:Init() : END");
	return self
end


function onEnter(self)
	self.super:onEnter()
	--print("PLScene: onEnter");
	if self.scene ~= nil then
		self.scene:onEnter()
	end
end


function onExit(self)
	self.super:onExit()
	--print("PLScene: onExit");
	if self.scene ~= nil then
		self.scene:onExit()
	end
end


function onUpdate(self, delta)
	--if (self.scene ~= nil and self.scene.onUpdate ~= nil) then
		self.scene:onUpdate(delta)
	--end
end