local function indexByName(moduleScript)
    return moduleScript.Name
end

return function(parent, recursive, indexFunc)
    indexFunc = indexFunc or indexByName
    local compiled = {}
    local children = (recursive and parent:GetDescendants()) or parent:GetChildren()

    for _,moduleScript in pairs(children) do
        if moduleScript:IsA("ModuleScript") then
            compiled[indexFunc(moduleScript)] = require(moduleScript)
        end
    end

    return compiled
end