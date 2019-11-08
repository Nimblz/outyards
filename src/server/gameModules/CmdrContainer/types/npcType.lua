local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local NPCS = require(common.NPCS)

return function (registry)
    local allNpcs = {}
    for id, _ in pairs(NPCS.byType) do
        table.insert(allNpcs, id)
    end

	registry:RegisterType("npcType", registry.Cmdr.Util.MakeEnumType("NPCType", allNpcs))
end