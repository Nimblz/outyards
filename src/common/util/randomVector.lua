return function()
    local rX = math.random() * 2 - 1
    local rY = math.random() * 2 - 1
    local rZ = math.random() * 2 - 1
    return Vector3.new(rX,rY,rZ).Unit
end