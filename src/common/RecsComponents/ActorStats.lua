local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "ActorStats",
    generator = function(props)
        props = props or {}

        return Dictionary.join({
            health = 30,
            maxHealth = 30,
            defense = 0, -- percent of dmg blocked
            moveSpeed = 20,
            baseDamage = 1, -- is modified by buffs and attack types
            attackRate = 1, -- per sec
            aggroRadius = 32,
            attackRange = 8,
            replicates = true,
        }, props)
    end,
})