require "PropertyHelper"

class = {}

-- A new inheritsFrom() function
--
function class.inheritFrom ( baseClass )

    local new_class = {}
    local class_mt = { __index = new_class }

    function new_class:new()
        local newinst = {}
        setmetatable( newinst, class_mt )
        return newinst
    end

    if nil ~= baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    -- Implementation of additional OO properties starts here --

    -- Return the class object of the instance
    function new_class:class()
        return new_class
    end

    -- Return the super class object of the instance
    function new_class:superClass()
        return baseClass
    end

    -- Return true if the caller is an instance of theClass
    function new_class:isa( theClass )
        local b_isa = false

        local cur_class = new_class

        while ( nil ~= cur_class ) and ( false == b_isa ) do
            if cur_class == theClass then
                b_isa = true
            else
                cur_class = cur_class:superClass()
            end
        end

        return b_isa
    end

	-- Return true if the caller is an instance of theClass
    function new_class:printHierarchy( theClass )
        local cur_class = new_class
        while ( nil ~= cur_class ) do
            print(table.tostring(cur_class))
            cur_class = cur_class:superClass()
        end
    end

    return new_class
end


function class.newInstance(className, getters, setters)
	local newInst = make_proxy(className, {}, getters, setters, false)
	if (newInst.superClass ~= nil) then
		--newInst.superClass().new()
	end
end

