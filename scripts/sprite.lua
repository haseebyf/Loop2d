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
local positioning_getters = {
  x = function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:position().x
  end,
  y = function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:position().y
  end
}

local positioning_setters = {
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
positioning_getters["alpha"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:alpha()
end

positioning_getters["alpha"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setAlpha(v)
end

positioning_getters["isVisible"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:visible()
end

positioning_getters["isVisible"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setVisible(v)
end



-- ===========================================================
-- Size
-- ===========================================================
-- content bounds
positioning_getters["contentBounds"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:boundingBox()
end

positioning_getters["contentBounds"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setBoundingBox(v)
end

-- content bounds
positioning_getters["contentHeight"] =  function(self)
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
positioning_getters["contentWidth"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

-- height
positioning_getters["height"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

positioning_getters["height"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setContentSize(CGSize(v, cc:contentSize().height))
end

-- width
positioning_getters["width"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

positioning_getters["width"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setContentSize(CGSize(cc:contentSize().width, v))
end




-- ===========================================================
-- Initialization
-- ===========================================================
function sprite.new(self, filename)
	local aSprite = CCSprite:spriteWithFile(filename)
	local priv = {__cc = aSprite}
	local self = make_proxy(sprite, priv, positioning_getters, positioning_setters, true)
	return self;
end


