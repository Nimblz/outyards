local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("common")

local by = require(common.util:WaitForChild("by"))
local compileSubmodulesToArray = require(common.util:WaitForChild("compileSubmodulesToArray"))
local assets = compileSubmodulesToArray(script, true)

return {
    all = assets,
    byType = by("npcType", assets),
}