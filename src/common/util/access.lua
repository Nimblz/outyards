return function(instance, path)
    assert(typeof(instance) == "Instance", "Argument 1 must be an instance!")
    assert(typeof(path) == "string", "Argument 2 must be a string!")

    local pathNodes = path:split(".")
    local currentChild = instance

    for _, lookingFor in ipairs(pathNodes) do
        currentChild = currentChild:FindFirstChild(lookingFor)

        if not currentChild then
            return nil
        end
    end

    return currentChild
end