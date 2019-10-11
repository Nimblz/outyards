local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "NPC",
    generator = function(props)
        props = props or {}
        local npcType = props.npcType
        return {
            npcType = npcType or "basicGrass",
            replicates = true,
        }
    end,
})