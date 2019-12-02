local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util
local projectileUtil = util.projectile

local requestHit = require(projectileUtil.requestHit)

local ParticleCreator = require(common.ParticleCreator)

return {
    id = "slowarrow",
    speed = 100,
    gravityScale = 0.25,

    onFire = function(entity, component, pzCore)
    end,

    onHit = function(entity, component, pzCore, hit, hitPos, normal)
        -- if its an enemy do damage

        ParticleCreator.spawnParticle("ring", {
            cFrame = entity.CFrame,
            scale = 0.5,
            amount = 1
        })

        -- request hit
        if component.owned then
            requestHit(hit, hitPos, 4, entity.CFrame.LookVector)
        end
    end,
}