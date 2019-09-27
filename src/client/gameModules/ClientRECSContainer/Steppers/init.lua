local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))
local Systems = require(script.Parent:WaitForChild("Systems"))

return {
    RECS.event(game:GetService("RunService").RenderStepped, {
        Systems.SpinnySystem
    }),
}