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