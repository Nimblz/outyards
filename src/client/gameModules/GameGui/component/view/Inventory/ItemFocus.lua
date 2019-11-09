local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)

return function(props)
    return Roact.createElement()
end