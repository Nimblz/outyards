local util = script.Parent
local requireSubmodules = require(util:WaitForChild("requireSubmodules"))

return function(parent, recursive)
    local unordered = requireSubmodules(parent,recursive)
    local compiled = {}

    for _, module in pairs(unordered) do
        table.insert(compiled, module)
    end

    return compiled
end