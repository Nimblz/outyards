local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local RECS = require(lib.RECS)
local Systems = require(script.Parent.Systems)

return {
    RECS.event(game:GetService("RunService").RenderStepped, {
        Systems.SpinnySystem,
        Systems.ProjectileMotionSystem,
        Systems.InteractableSystem,
    }),
}