local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local event = ReplicatedStorage:WaitForChild("event")
local common = ReplicatedStorage:WaitForChild("common")

local ParticleCreator = require(common:WaitForChild("ParticleCreator"))

local eAttackActor = event:WaitForChild("eAttackActor")

return {
    id = "bullet",
    speed = 200,
    gravityScale = 0.25,

    onFire = function(entity, component, pzCore)
        ParticleCreator.spawnParticle("spark", entity.CFrame, 0.3, 1)
    end,

    onHit = function(entity, component, pzCore, hit)
        -- if its an enemy do damage

        ParticleCreator.spawnParticle("spark", entity.CFrame, 0.5, 1)

            -- find npcs
        local cornerOffset = Vector3.new(1,1,1)*4
        local topCorner = entity.CFrame.p + cornerOffset
        local bottomCorner = entity.CFrame.p - cornerOffset
        local testRegion = Region3.new(bottomCorner,topCorner)

        local parts = workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

        for _,v in pairs(parts) do
            eAttackActor:FireServer(v)
        end
    end,
}