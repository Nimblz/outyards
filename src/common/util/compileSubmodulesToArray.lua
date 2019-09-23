local util = script.Parent
local compileSubmodules = require(util:WaitForChild("compileSubmodules"))

return function(parent, recursive)
    local unordered = compileSubmodules(parent,recursive)
    local compiled = {}

    for _, module in pairs(unordered) do
        table.insert(compiled, module)
    end

    return compiled
end