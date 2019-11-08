local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common

local by = require(common.util.by)
local compileSubmodulesToArray = require(common.util.compileSubmodulesToArray)
local behaviors = compileSubmodulesToArray(script, true)

return {
    all = behaviors,
    byId = by("id", behaviors),
}