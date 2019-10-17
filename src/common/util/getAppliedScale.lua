-- searches for all scale objects that could be affecting passed instance
local function getChildrenOfClass(instance, className)
	local result = {}
	if instance == game then return result end
	for _, child in pairs(instance:GetChildren()) do
		if child:IsA(className) then
			table.insert(result, child)
		end
	end
	return result
end

local function getAppliedScale(instance)
    local finalScale = 1
    local currentPosition = instance

	while true do
        currentPosition = currentPosition.Parent

		local scales = getChildrenOfClass(currentPosition, "UIScale")
		for _, scaleInstance in pairs(scales) do
			finalScale = finalScale * scaleInstance.Scale
        end

        if not currentPosition.Parent then
            break
        end
	end

	return finalScale
end

return getAppliedScale