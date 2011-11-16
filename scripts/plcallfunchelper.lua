waxClass{"PLCallFuncHelper", NSObject}

function prepareAction(self, aFunction)
	self.callback = aFunction
	return CCCallFunc:actionWithTarget_selector(self, "callbackCalled")
end

function callbackCalled(self)
	self.callback()
end