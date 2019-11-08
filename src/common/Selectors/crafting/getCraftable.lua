local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Items = require(common.Items)

local canCraft = require(script.Parent.canCraft)

local function getCraftable(state,player)
    local craftable = {}

    for id, item in pairs(Items.byId) do
        if item.recipe then
            if canCraft(state,player,id) then
                craftable[id] = true
            end
        end
    end
    return craftable
end

return getCraftable