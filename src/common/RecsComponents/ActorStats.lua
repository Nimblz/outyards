local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ActorStats",
    generator = function()
        return {
            health = 30,
            maxHealth = 30,
            defense = 0, -- percent of dmg blocked
            moveSpeed = 10,
            baseDamage = 1, -- is modified by buffs and attack types
            attackRate = 1, -- per sec
            aggroRadius = 12,
        }
    end,
})