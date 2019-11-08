local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common

local by = require(common.util.by)
local compileSubmodulesToArray = require(common.util.compileSubmodulesToArray)
local assets = compileSubmodulesToArray(script, true)

return {
    all = assets,
    byType = by("npcType", assets),
}