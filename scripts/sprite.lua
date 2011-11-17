--require "loop2d"
-- ===========================================================
-- Defining the package
-- ===========================================================
sprite = lua.class({}, node)
-- sprite.__index = sprite

-- ===========================================================
-- create metatable
--[[ ===========================================================
local mt = {
	-- accessor
	__index = function (t,k)
		print("*access to element " .. k)
		if k == "x" then
			return t[sprite].__cc:position().x
		elseif k == "y" then
			return t[sprite].__cc:position().y
		else
			return t[sprite][k]   -- access the original table
		end
	end,
    
	-- setter
	__newindex = function (t,k,v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		if k == "x" then
			t[sprite].__cc:setPosition(CGPoint(v,t[sprite].__cc:position().y))
		elseif k == "y" then
			t[sprite].__cc:setPosition(CGPoint(t[sprite].__cc:position().x,v))
		else 
			t[sprite][k] = v   -- update original table
		end
	end
}
--]]






-- ===========================================================
-- Actions
-- ===========================================================
function sprite:runAction(anAction)
	print(table.tostring(anAction.__cc))
	self.__cc:runAction(anAction.__cc)
end

-- ===========================================================
-- Initialization
-- ===========================================================
function sprite:__init(filename)
	print("sprite.__init() : START")
	local aSprite = CCSprite:spriteWithFile(filename)
	local newInstance = lua.rawnew(self, {__cc = aSprite})
	newInstance = make_proxy(newInstance, {}, self.getters, self.setters, false)
	aSprite.scene = newInstance
	print("sprite.__init() : END")
	return newInstance
end


