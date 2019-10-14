local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local event = ReplicatedStorage:WaitForChild("event")
local common = ReplicatedStorage:WaitForChild("common")

local ParticleCreator = require(common:WaitForChild("ParticleCreator"))

local eAttackActor = event:WaitForChild("eAttackActor")

return {
    id = "bullet",
    speed = 300,
    gravityScale = 1/3,

    onFire = function(entity, component, pzCore)
        ParticleCreator.spawnParticle("spark", {
            cFrame = entity.CFrame,
            scale = 0.3,
            amount = 1
        })
    end,

    onHit = function(entity, component, pzCore, hit, hitPos, normal)
        -- if its an enemy do damage

        ParticleCreator.spawnParticle("ring", {
            cFrame = entity.CFrame,
            scale = 0.5,
            amount = 1
        })
            -- find npcs
        local cornerOffset = Vector3.new(1,1,1)*4
        local topCorner = entity.CFrame.p + cornerOffset
        local bottomCorner = entity.CFrame.p - cornerOffset
        local testRegion = Region3.new(bottomCorner,topCorner)

        local parts = workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

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