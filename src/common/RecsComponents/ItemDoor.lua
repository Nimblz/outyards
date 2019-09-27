local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ItemDoor",
    generator = function()
        return {
            keyItem = "pepperoni"
        }
    end,
})