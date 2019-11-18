local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local event = ReplicatedStorage.event
local common = ReplicatedStorage.common

local ParticleCreator = require(common.ParticleCreator)

local eAttackActor = event.eAttackActor

return {
    id = "arrow",
    speed = 150,
    gravityScale = 0.1,

    onFire = function(entity, component, pzCore)
    end,

    onHit = function(entity, component, pzCore, hit, hitPos, normal)
        -- if its an enemy do damage

        ParticleCreator.spawnParticle("circle", {
            cFrame = entity.CFrame,
            scale = 0.5,
            amount = 1
        })
            -- find npcs
        local cornerOffset = Vector3.new(1,1,1)*2
        local topCorner = entity.CFrame.p + cornerOffset
        local bottomCorner = entity.CFrame.p - cornerOffset
        local testRegion = Region3.new(bottomCorner,topCorner)

        local parts = Workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

        if component.owned then
            if CollectionService:HasTag(hit, "ActorStats") then
                eAttackActor:FireServer(hit)
            end

            for _,v in pairs(parts) do
                if v ~= hit then
                    eAttackActor:FireServer(v)
                end
            end
        end
    end,
}