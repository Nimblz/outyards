local function mapToRange(x, inMin, inMax, outMin, outMax)
    local unconstrained = (x-inMin)/(inMax-inMin) * (outMax-outMin) + outMin
    local clampMin = outMin < outMax and outMin or outMax
    local clampMax = outMin > outMax and outMin or outMax
    return math.clamp(unconstrained, clampMin, clampMax)
end

return mapToRange