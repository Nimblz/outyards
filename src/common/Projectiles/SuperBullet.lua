local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util
local projectileUtil = util.projectile

local requestHit = require(projectileUtil.requestHit)

local ParticleCreator = require(common.ParticleCreator)

return {
    id = "superbullet",
    speed = 1024,
    gravityScale = 1,

    onFire = function(entity, component, pzCore)
        ParticleCreator.spawnParticle("spark", {
            cFrame = entity.CFrame,
            scale = 0.3,
            amount = 1
        })
    end,

    onUpdate = function(entity, component, pzCore)
        entity.Color = Color3.fromHSV((tick() - component.fireTime or 0)%1,0.75,1)
    end,

    onHit = function(entity, component, pzCore, hit, hitPos, normal)
        -- if its an enemy do damage

        local scaleMod = math.random()

        ParticleCreator.spawnParticle("circle", {
            cFrame = entity.CFrame,
            scale = 0.5+(scaleMod/2),
            amount = 1
        })

        ParticleCreator.spawnParticle("ring", {
            cFrame = entity.CFrame,
            scale = 1+scaleMod,
            amount = 1
        })

        -- request hit
        if component.owned then
            requestHit(hit, hitPos, 8, entity.CFrame.LookVector)
        end
    end,
}