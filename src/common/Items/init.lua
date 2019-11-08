local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common

local by = require(common.util.by)
local compileSubmodulesToArray = require(common.util.compileSubmodulesToArray)
local assets = compileSubmodulesToArray(script, true)

for _, item in pairs(assets) do
    item.spriteSheet = item.spriteSheet or "materials"
    item.spriteCoords = item.spriteCoords or Vector2.new(16,16)
    item.sortOrder = item.tier
    if item.equipmentType then item.sortOrder = item.sortOrder + 100 end

    if not item.tags then warn(("%s has no tags!"):format(item.id)) end
end

local function isTierLower(asset1,asset2)
    return asset1.tier < asset2.tier
end

table.sort(assets,isTierLower)

return {
    all = assets,
    byId = by("id", assets),
}