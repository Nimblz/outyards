local Players = game:GetService("Players")

local function pointsCloserThan(p1,p2,dist)
    local delta = p1-p2

    return ((delta.X*delta.X) + (delta.Y*delta.Y) + (delta.Z*delta.Z)) <= dist*dist
end

local function findCharacterNear(instance, radius)
    local closestDist = radius
    local closestChar
    for _, player in pairs(Players:getPlayers()) do
        local character = player.character
        if not character then return end
        local root = character.PrimaryPart
        if not root then return end
        if pointsCloserThan(root.CFrame.p , instance.CFrame.p, closestDist) then
            closestChar = character
        end
    end

    return closestChar
end

return function(entity, recs, pz)
    -- stuff only the state machine cares about, things that might be useful to have access to between states
    local actorStats = recs:getComponent(entity, recs:getComponentClass("ActorStats"))
    local driver = recs:getComponent(entity, recs:getComponentClass("NPCDriver"))
    local props = {}
    return {
        awake = {
            enter = function()
                return "idle"
            end,
            step = function()
            end,
        },
        idle = {
            enter = function()
            end,
            step = function()
                local character = findCharacterNear(entity, actorStats.aggroRadius)
                if character then
                    return "chase", character
                end
            end,
        },
        chase = {
            enter = function(target)
                props.target = target
            end,
            step = function()
                local target = props.target
                local targetRoot = target.PrimaryPart
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
                local targetMoveDir = (targetPosXZ-selfPosXZ).unit
                local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, 6)

                if closeEnoughToAttack then
                    driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
                    --return "attack", target
                else
                    driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,targetPosXZ).lookVector)
                    driver:updateProperty("targetVelocity", targetMoveDir * actorStats.moveSpeed)
                end
            end,
            leaving = function()
                props.target = nil
            end
        },
        attack = {
            enter = function(target)
                driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
            end,
            step = function()
            end,
        },
        goHome = {
            enter = function()
            end,
            step = function()
            end,
        },
        dead = { -- entered when health reaches zero. will yield until previous state's enter is finished
            enter = function()
            end,
            step = function()
            end,
        },
    }
end