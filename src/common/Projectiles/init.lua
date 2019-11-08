local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local model = ReplicatedStorage.model.projectile

local by = require(common.util.by)
local compileSubmodulesToArray = require(common.util.compileSubmodulesToArray)
local assets = compileSubmodulesToArray(script, true)

return {
    all = assets,
    byId = by("id", assets),
    getModelForId = function(id)
        return model:FindFirstChild(id)
    end
}