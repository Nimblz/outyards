local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "Interactable",
    generator = function()
        return {
            enabled = true,
            replicates = true,
            maxUseDistance = 24,
        }
    end,
})