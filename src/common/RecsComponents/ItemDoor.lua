local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "ItemDoor",
    generator = function()
        return {
            keyItem = "pepperoni"
        }
    end,
})