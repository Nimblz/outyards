local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ActorStats",
    generator = function()
        return {
            health = 30,
            maxHealth = 30,
            defense = 0,
            moveSpeed = 10,
            baseDamage = 1,
            attackRate = 1, -- per sec
        }
    end,
})