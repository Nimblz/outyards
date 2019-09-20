--[[
    Author: Lucien Greathouse
    https://github.com/LPGhatguy/rdc-project/blob/master/src/server/networkMiddleware.lua
	This is a fairly abstract middleware that enables you to replicate events
	to another store via whatever mechanism. It doesn't impose any sort of
    filtering or propose any solutions, those are handled in main.

    How to use:
    This module returns a function that returns a middleware based on the passed replicate function.
    When an action is dispatched to the store, this middleware calls the passed replicate
    function with the action + state info
]]

local function networkMiddleware(replicate)
	return function(nextDispatch, store)
		return function(action)
			local beforeState = store:getState()
			local result = nextDispatch(action)
			local afterState = store:getState()

			replicate(action, beforeState, afterState)

			return result
		end
	end
end

return networkMiddleware