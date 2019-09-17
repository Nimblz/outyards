return function(parent, recursive)
    local compiled = {}
    local children = (recursive and parent:GetDescendants()) or parent:GetChildren()

    for _,moduleScript in pairs(children) do
        if moduleScript:IsA("ModuleScript") then
            local required = require(moduleScript)
            table.insert(compiled, required)
        end
    end

    return compiled
end