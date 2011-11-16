waxClass{"PLButtonHelper", CCButton}


function init(self)
	self = self.super:init()
	self:addTarget_action_forEvent(self, "onPress", 0)
	self:addTarget_action_forEvent(self, "onRelease", 1)
	self:addTarget_action_forEvent(self, "onCancel", 2)
	return self;
end


function onPress(self)
	if (self.__lp ~= nil and self.__lp.onPress ~= nil) then
		self.__lp.onPress(self.__lp)
	end
end


function onRelease(self)
	if (self.__lp ~= nil and self.__lp.onRelease ~= nil) then
		self.__lp.onRelease(self.__lp)
	end
end


function onCancel(self)
	if (self.__lp ~= nil and self.__lp.onCancel ~= nil) then
		self.__lp.onCancel(self.__lp)
	end
end