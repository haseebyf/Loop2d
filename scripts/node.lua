node = lua.class{
					getters = {},
					setters = {},
					__cc = nil
				}
				
-- ===========================================================
-- Transparancy
-- ===========================================================
node.getters["alpha"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:alpha()
end

node.setters["alpha"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setAlpha(v)
end

node.getters["isVisible"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:visible()
end

node.setters["isVisible"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setVisible(v)
end



-- ===========================================================
-- Size
-- ===========================================================
-- content bounds
node.getters["contentBounds"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:boundingBox()
end

node.setters["contentBounds"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setBoundingBox(v)
end

-- content bounds
node.getters["contentHeight"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:boundingBox().height
end
--[[
positioning_node.getters["contentHeight"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setBoundingBox(v)
end
--]]

-- content width
node.getters["contentWidth"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

-- height
node.getters["height"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

node.setters["height"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
    cc:setContentSize(CGSize(v, cc:contentSize().height))
end

-- width
node.getters["width"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:contentSize().width
end

node.setters["width"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setContentSize(CGSize(cc:contentSize().width, v))
end

-- ===========================================================
-- scaling
-- ===========================================================
node.getters["scaleX"] =  function(self)
	local cc = self.__cc
	return cc:scaleX()
end

node.setters["scaleX"] = function(self, v)
    local cc = self.__cc
	cc:setScaleX(v)
end

node.getters["scaleY"] =  function(self)
    local cc = self.__cc
	return cc:scaleY()
end

node.setters["scaleY"] = function(self, v)
    local cc = self.__cc
	cc:setScaleY(v)
end

-- ===========================================================
-- rotation
-- ===========================================================
node.getters["rotation"] =  function(self)
    local cc = self.__cc
	return cc:rotation().x
end

node.setters["rotation"] = function(self, v)
    local cc = self.__cc
	cc:setRotation(v)
end


-- ===========================================================
-- positioning
-- ===========================================================
-- x 
node.getters["x"] =  function(self)
    local cc = self.__cc
	return cc:position().x
end

node.setters["x"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(v,cc:position().y))
end

-- y
node.getters["y"] =  function(self)
    local cc = self.__cc
	return cc:position().y
end

node.setters["y"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(cc:position().x,v))
end

-- position
node.getters["position"] =  function(self)
    local cc = self.__cc
	return cc:position()
end

node.setters["position"] = function(self, v)
    local cc = self.__cc
	cc:setPosition(CGPoint(v.x,v.y))
end

-- xOrigin
node.getters["xOrigin"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

node.setters["xOrigin"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

-- yOrigin
node.getters["yOrigin"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

node.setters["yOrigin"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end

-- xReference
node.getters["xReference"] =  function(self)
    local cc = getmetatable(self).priv.__cc
	return cc:rotation()
end

node.setters["xReference"] = function(self, v)
    local cc = getmetatable(self).priv.__cc
	cc:setRotation(v)
end
