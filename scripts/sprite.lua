--require "loop2d"
-- ===========================================================
-- Defining the package
-- ===========================================================
sprite = lua.class({__cc = nil}, node)
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
-- Positioning
-- ===========================================================
local getters = {}

local setters = {}

-- ===========================================================
-- Transparancy
-- ===========================================================
getters["alpha"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:alpha()
end

setters["alpha"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setAlpha(v)
end

getters["isVisible"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:visible()
end

setters["isVisible"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setVisible(v)
end



-- ===========================================================
-- Size
-- ===========================================================
-- content bounds
getters["contentBounds"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:boundingBox()
end

setters["contentBounds"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setBoundingBox(v)
end

-- content bounds
getters["contentHeight"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:boundingBox().height
end
--[[
positioning_getters["contentHeight"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setBoundingBox(v)
end
--]]

-- content width
getters["contentWidth"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

-- height
getters["height"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

setters["height"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setContentSize(CGSize(v, cc:contentSize().height))
end

-- width
getters["width"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

setters["width"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setContentSize(CGSize(cc:contentSize().width, v))
end

-- ===========================================================
-- scaling
-- ===========================================================
getters["scaleX"] =  function(self)
	local cc = self.__cc
	return cc:scaleX()
end

setters["scaleX"] = function(self, v)
    local cc = self.__cc
	cc:setScaleX(v)
end

getters["scaleY"] =  function(self)
    local cc = self.__cc
	return cc:scaleY()
end

setters["scaleY"] = function(self, v)
    local cc = self.__cc
	cc:setScaleY(v)
end

-- ===========================================================
-- rotation
-- ===========================================================
getters["rotation"] =  function(self)
    local cc = self.__cc
	return cc:rotation().x
end

setters["rotation"] = function(self, v)
    local cc = self.__cc
	cc:setRotation(v)
end


-- ===========================================================
-- positioning
-- ===========================================================
-- x 
getters["x"] =  function(self)
    local cc = self.__cc
	return cc:position().x
end

setters["x"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(v,cc:position().y))
end

-- y
getters["y"] =  function(self)
    local cc = self.__cc
	return cc:position().y
end

setters["y"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(cc:position().x,v))
end

-- position
getters["position"] =  function(self)
    local cc = self.__cc
	return cc:position()
end

setters["position"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(v.x,v.y))
end

-- xOrigin
getters["xOrigin"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["xOrigin"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

-- yOrigin
getters["yOrigin"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["yOrigin"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

-- xReference
getters["xReference"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["xReference"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

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
	newInstance = make_proxy(newInstance, {}, getters, setters, false)
	aSprite.scene = newInstance
	print("sprite.__init() : END")
	return newInstance


	--local newInstance = make_proxy(sprite, {}, getters, setters, false)
	--local aSprite = CCSprite:spriteWithFile(filename)
	--newInstance.__cc = aSprite
	--newInstance.__cc.scene = newInstance
	--return newInstance;
end


