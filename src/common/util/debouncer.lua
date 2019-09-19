-- when this module is called it returns a function that wraps the passed 'func' arg
-- when that function is called it will wait 't' seconds before allowing func to be called again
-- if the wrapper is called within this window nothing will happen

local function debouncer(t,func)
	local debounce = false
	return function(...)
		if not debounce then
			debounce = true
			func(...)
			wait(t)
			debounce = false
		end
	end
end

return debouncer