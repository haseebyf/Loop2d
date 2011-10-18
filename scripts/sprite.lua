require "PropertyHelper"
-- ===========================================================
-- Defining the package
-- ===========================================================
sprite = { }
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
local getters = {
  x = function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:position().x
  end,
  y = function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:position().y
  end
}

local setters = {
  x = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setPosition(CGPoint(v,cc:position().y))
  end,
  y = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setPosition(CGPoint(cc:position().x, v))
  end
}

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
    local cc = getmetatable(self).priv.__cc
	return cc:scaleX()
end

setters["scaleX"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setScaleX(v)
end

getters["scaleY"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:scaleY()
end

setters["scaleY"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setScaleY(v)
end

-- ===========================================================
-- rotation
-- ===========================================================
getters["rotation"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["rotation"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end


-- ===========================================================
-- positioning
-- ===========================================================
-- x 
getters["x"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["x"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

-- y
getters["x"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

setters["x"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
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
-- Initialization
-- ===========================================================
function sprite.new(self, filename)
	local aSprite = CCSprite:spriteWithFile(filename)
	local priv = {__cc = aSprite}
	local self = make_proxy(sprite, priv, getters, setters, true)
	return self;
end


