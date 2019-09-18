local errors = {
    loadFail = "Module [%s] failed to load! Threw: %s"
}

local function indexByName(moduleScript)
    return moduleScript.Name
end

return function(parent, recursive, indexFunc)
    indexFunc = indexFunc or indexByName
    local compiled = {}
    local children = (recursive and parent:GetDescendants()) or parent:GetChildren()

    for _,moduleScript in pairs(children) do
        if moduleScript:IsA("ModuleScript") then
            local success, err = pcall(function()
                compiled[indexFunc(moduleScript)] = require(moduleScript)
            end)
            if not success then
                error(errors.loadFail:format(moduleScript:GetFullName(), tostring(err)))
            end
        end
    end

    return compiled
end