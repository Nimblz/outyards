local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

local event = ReplicatedStorage.event
local common = ReplicatedStorage.common

local eAttackActor = event.eAttackActor

local makeHit = require(common.makeHit)

return function(hit, position, radius, direction)
    local cornerOffset = Vector3.new(1,1,1)*radius
    local topCorner = position + cornerOffset
    local bottomCorner = position - cornerOffset
    local testRegion = Region3.new(bottomCorner,topCorner)

    local parts = Workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))


    if CollectionService:HasTag(hit, "ActorStats") then
        local hitInfo = makeHit({
            target = hit,
            direction = direction
        })
        eAttackActor:FireServer(hitInfo)
    end

    for _,v in pairs(parts) do
        if v ~= hit then
            local hitInfo = makeHit({
                target = v,
                direction = direction
            })
            eAttackActor:FireServer(hitInfo)
        end
    end
end