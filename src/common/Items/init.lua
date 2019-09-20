local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("common")

local by = require(common.util:WaitForChild("by"))
local compileSubmodulesToArray = require(common.util:WaitForChild("compileSubmodulesToArray"))
local assets = compileSubmodulesToArray(script, true)

local function isTierLower(asset1,asset2)
    return asset1.tier < asset2.tier
end

table.sort(assets,isTierLower)

return {
    all = assets,
    byId = by("id", assets),
}