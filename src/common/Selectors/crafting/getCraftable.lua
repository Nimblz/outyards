local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Items = require(common:WaitForChild("Items"))

local canCraft = require(script.Parent:WaitForChild("canCraft"))

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