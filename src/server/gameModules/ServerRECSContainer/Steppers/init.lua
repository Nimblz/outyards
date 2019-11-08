local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local RECS = require(lib.RECS)
local Systems = require(script.Parent.Systems)

return {
    RECS.interval(1/15, {
        Systems.AISystem
    }),
    RECS.interval(1/2, {
        Systems.SpawnZoneSystem
    })
}