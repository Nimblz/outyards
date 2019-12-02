local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util
local projectileUtil = util.projectile
local requestHit = require(projectileUtil.requestHit)

local ParticleCreator = require(common.ParticleCreator)

return {
    id = "scoobis",
    speed = 200,
    gravityScale = 0,

    onFire = function(entity, component, pzCore)
        ParticleCreator.spawnParticle("spark", {
            cFrame = entity.CFrame,
            scale = 1,
            amount = 1
        })
    end,

    onHit = function(entity, component, pzCore, hit, hitPos, normal)
        -- if its an enemy do damage

        ParticleCreator.spawnParticle("thinring", {
            cFrame = entity.CFrame,
            scale = 8,
            amount = 1,
            timeScale = 1
        })

        ParticleCreator.spawnParticle("circle", {
            cFrame = entity.CFrame,
            scale = 5,
            amount = 1,
            timeScale = 1/3
        })

        if component.owned then
            if component.owned then
                requestHit(hit, hitPos, 64, entity.CFrame.LookVector)
            end
        end
    end,
}