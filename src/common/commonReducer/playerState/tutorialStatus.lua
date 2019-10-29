local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local Rodux = require(lib:WaitForChild("Rodux"))

return Rodux.createReducer(1, {
    TUTORIAL_NEXT = function(state, action)
        return state + 1
    end,
})