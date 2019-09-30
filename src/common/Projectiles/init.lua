local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("common")
local model = ReplicatedStorage:WaitForChild("model"):WaitForChild("projectile")

local by = require(common.util:WaitForChild("by"))
local compileSubmodulesToArray = require(common.util:WaitForChild("compileSubmodulesToArray"))
local assets = compileSubmodulesToArray(script, true)

return {
    all = assets,
    byId = by("id", assets),
    getModelForId = function(id)
        return model:FindFirstChild(id)
    end
}