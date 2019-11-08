local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "DamagedBy",
    generator = function()
        return {
            players = {}
        }
    end,
})