local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Items = require(common.Items)

return function (registry)
    local allItems = {}
    for id, item in pairs(Items.byId) do
        table.insert(allItems, id)
    end

	registry:RegisterType("itemId", registry.Cmdr.Util.MakeEnumType("ItemId", allItems))
end