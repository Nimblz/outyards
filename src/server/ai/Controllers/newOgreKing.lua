local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

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
    local state = {}

    local function getSelfInfo()
        local selfPos = entity.Position
        local floorPos = (entity.CFrame * CFrame.new(0,-entity.Size.Y/2,0)).p
        local homePos = state.homePos
        local selfPosXZ = entity.Position * Vector3.new(1,0,1)
        local homePosXZ = state.homePos * Vector3.new(1,0,1)
        local lookVec = entity.CFrame.lookVector
        local tooFarFromHome = not pointsCloserThan(selfPosXZ,homePosXZ,actorStats.aggroRadius * 4)

        return {
            selfPos = selfPos,
            floorPos = floorPos,
            homePos = homePos,
            selfPosXZ = selfPosXZ,
            homePosXZ = homePosXZ,
            lookVec = lookVec,
            tooFarFromHome = tooFarFromHome,
        }
    end

    local function getTargetInfo(target)
        if not target then return end

        local selfInfo = getSelfInfo()
        local selfPosXZ = selfInfo.selfPosXZ

        local targetRoot = target.PrimaryPart
        if not targetRoot then return end
        local targetHumanoid = target:FindFirstChild("Humanoid")
        if not targetHumanoid then return end
        local isAlive = targetHumanoid.Health > 0
        local targetPos = targetRoot.Position
        local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
        local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, actorStats.attackRange)

        return {
            target = target,
            targetRoot = targetRoot,
            targetHumanoid = targetHumanoid,
            isAlive = isAlive,
            targetPos = targetPos,
            targetPosXZ = targetPosXZ,
            closeEnoughToAttack = closeEnoughToAttack,
        }
    end

    local function lookAtPos(position)
        local selfPosXZ = entity.Position * Vector3.new(1,0,1)
        local lookPosXZ = position * Vector3.new(1,0,1)

        driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,lookPosXZ).lookVector)
    end

    local function lookAtTarget(target)
        local targetInfo = getTargetInfo(target)
        if not targetInfo then return end

        lookAtPos(targetInfo.targetPos)
    end

    local function moveTowardsPos(position)
        local selfPosXZ = entity.Position * Vector3.new(1,0,1)
        local goalPosXZ = position * Vector3.new(1,0,1)
        local targetMoveDir = (goalPosXZ-selfPosXZ).unit

        driver:updateProperty("targetVelocity", targetMoveDir * actorStats.moveSpeed)
    end

    local function moveTowardsTarget(target)
        local targetInfo = getTargetInfo(target)
        if not targetInfo then return end

        moveTowardsPos(targetInfo.targetPos)
    end

    local function stopMoving()
        driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
    end

    local function aggrocheck()
        local selfInfo = getSelfInfo()
        local homePosXZ = selfInfo.homePosXZ

        local character = findCharacterNear(entity, actorStats.aggroRadius)
        if not character then return end
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local rootPosXZ = root.Position * Vector3.new(1,0,1)
        local tooFarFromHome = not pointsCloserThan(rootPosXZ,homePosXZ,actorStats.aggroRadius * 3)
        if tooFarFromHome then return end

        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        if humanoid.Health <= 0 then return end

        return character
    end

    return {
        awake = {
            enter = function()
                state.homePos = entity.Position
                return "idle"
            end,
            step = function()
            end,
        },
        idle = {
            enter = function()
                stopMoving()
            end,
            step = function()
                local character = aggrocheck()
                if character then
                    return "chase", character
                end
            end,
        },
        chase = {
            enter = function(target)
                state.target = target
            end,
            step = function()
                local target = state.target
                local targetInfo = getTargetInfo(target)
                if not targetInfo then return "goHome" end

                local tooFarFromHome = targetInfo.tooFarFromHome
                local isAlive = targetInfo.isAlive
                local closeEnoughToAttack = targetInfo.closeEnoughToAttack

                if tooFarFromHome or (not isAlive) then return "goHome" end

                if closeEnoughToAttack then
                    stopMoving()
                    lookAtTarget(target)
                    return "attack", target
                else
                    lookAtTarget(target)
                    moveTowardsTarget(target)
                end
            end,
            leaving = function()
                state.target = nil
            end
        },
        attack = {
            enter = function(target)
                state.target = target
                stopMoving()

                local targetInfo = getTargetInfo(target)
                local selfInfo = getSelfInfo()

                if not targetInfo then return "goHome" end
                if not selfInfo then return "goHome" end

                local tooFarFromHome = targetInfo.tooFarFromHome
                local isAlive = targetInfo.isAlive

                local floorPos = selfInfo.floorPos
                local lookVec = selfInfo.lookVec

                if tooFarFromHome or (not isAlive) then return "goHome" end

                local attackRay = Ray.new(floorPos + Vector3.new(0,3,0),lookVec*(actorStats.attackRange))

                local hit = Workspace:FindPartOnRayWithIgnoreList(attackRay, CollectionService:GetTagged("AI"))
                if hit then
                    local humanoid =
                        hit.Parent:FindFirstChild("Humanoid") or
                        hit.Parent.Parent:FindFirstChild("Humanoid")

                    if humanoid then
                        humanoid:TakeDamage(actorStats.baseDamage)
                    end
                end


                wait(1/actorStats.attackRate)

                targetInfo = getTargetInfo(target)
                if not targetInfo then return "goHome" end
                local closeEnoughToAttack = targetInfo.closeEnoughToAttack
                isAlive = targetInfo.isAlive

                if closeEnoughToAttack and isAlive then
                    return "attack", target
                elseif isAlive then
                    return "chase", target
                else
                    return "goHome"
                end
            end,
            step = function()
                -- keep looking at target
                lookAtTarget(state.target)
            end,
            leaving = function()
                state.target = nil
            end
        },
        goHome = {
            animationOverride = "chase",
            enter = function()
            end,
            step = function()
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local homePosXZ = state.homePos * Vector3.new(1,0,1)
                local isCloseEnough = pointsCloserThan(selfPosXZ,homePosXZ,1)

                lookAtPos(homePosXZ)
                moveTowardsPos(homePosXZ)

                if isCloseEnough then
                    return "idle"
                end

                local character = aggrocheck()
                if character then
                    return "chase", character
                end
            end,
        },
        dead = { -- entered when health reaches zero. will yield until previous state's enter is finished
            enter = function()
                stopMoving()
                wait(3)
            end,
            step = function()
            end,
        },
    }
end