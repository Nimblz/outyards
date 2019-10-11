local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))
local Systems = require(script.Parent:WaitForChild("Systems"))

return {
    RECS.interval(1/15, {
        Systems.AISystem
    }),
    RECS.interval(1/2, {
        Systems.SpawnZoneSystem
    })
}