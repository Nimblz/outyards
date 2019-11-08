local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local Rodux = require(lib.Rodux)

return Rodux.createReducer(1, {
    TUTORIAL_NEXT = function(state, action)
        return state + 1
    end,
})