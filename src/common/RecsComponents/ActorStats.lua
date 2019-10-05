local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ActorStats",
    generator = function(props)
        return Dictionary.join({
            health = 30,
            maxHealth = 30,
            defense = 0, -- percent of dmg blocked
            moveSpeed = 20,
            baseDamage = 3, -- is modified by buffs and attack types
            attackRate = 1, -- per sec
            aggroRadius = 64,
            attackRange = 12,
        },props)
    end,
})