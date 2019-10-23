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
    local props = {}
    return {
        awake = {
            enter = function()
                props.homePos = entity.Position
                return "idle"
            end,
            step = function()
            end,
        },
        idle = {
            enter = function()
                driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
            end,
            step = function()
                local character = findCharacterNear(entity, actorStats.aggroRadius)
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if not humanoid then return end
                    if humanoid.Health <= 0 then return end
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
                local targetHumanoid = target:FindFirstChild("Humanoid")
                local isAlive = targetHumanoid.Health > 0
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local homePosXZ = props.homePos * Vector3.new(1,0,1)
                local tooFarFromHome = not pointsCloserThan(selfPosXZ,homePosXZ,actorStats.aggroRadius * 3)
                local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
                local targetMoveDir = (targetPosXZ-selfPosXZ).unit
                local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, actorStats.attackRange)

                if tooFarFromHome or (not isAlive) then return "goHome" end

                if closeEnoughToAttack then
                    driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
                    driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,targetPosXZ).lookVector)
                    return "attack", target
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
                props.target = target
                driver:updateProperty("targetVelocity", Vector3.new(0,0,0))

                local selfPos = entity.Position
                local lookVec = entity.CFrame.lookVector
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local homePosXZ = props.homePos * Vector3.new(1,0,1)
                local targetRoot = target.PrimaryPart
                local targetHumanoid = target:FindFirstChild("Humanoid")
                local isAlive = targetHumanoid.Health > 0
                local tooFarFromHome = not pointsCloserThan(selfPosXZ,homePosXZ,actorStats.aggroRadius * 3)
                local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
                local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, actorStats.attackRange)

                if tooFarFromHome or (not isAlive) then return "goHome" end

                local attackRay = Ray.new(selfPos,lookVec*(actorStats.attackRange+2))

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
                if closeEnoughToAttack then
                    print("attack again!")
                    return "attack", target
                else
                    return "chase", target
                end
            end,
            step = function()
                local target = props.target
                local targetRoot = target.PrimaryPart
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
                --local targetMoveDir = (targetPosXZ-selfPosXZ).unit


                driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,targetPosXZ).lookVector)
                --driver:updateProperty("targetVelocity", targetMoveDir * actorStats.moveSpeed)
            end,
            leaving = function()
                props.target = nil
            end
        },
        goHome = {
            animationOverride = "chase",
            enter = function()
            end,
            step = function()
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local homePosXZ = props.homePos * Vector3.new(1,0,1)
                local isCloseEnough = pointsCloserThan(selfPosXZ,homePosXZ,1)
                local targetMoveDir = (homePosXZ-selfPosXZ).unit

                driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,homePosXZ).lookVector)
                driver:updateProperty("targetVelocity", targetMoveDir * actorStats.moveSpeed)

                if isCloseEnough then
                    return "idle"
                end

                local character = findCharacterNear(entity, actorStats.aggroRadius)
                if character then
                    local root = character:FindFirstChild("HumanoidRootPart")
                    if not root then return end
                    local rootPosXZ = root.Position * Vector3.new(1,0,1)
                    local tooFarFromHome = not pointsCloserThan(rootPosXZ,homePosXZ,actorStats.aggroRadius * 3)
                    if tooFarFromHome then return end
                    local humanoid = character:FindFirstChild("Humanoid")
                    if not humanoid then return end
                    if humanoid.Health <= 0 then return end
                    return "chase", character
                end
            end,
        },
        dead = { -- entered when health reaches zero. will yield until previous state's enter is finished
            enter = function()
                driver:updateProperty("disabled", true)
                entity.Velocity = Vector3.new(
                    math.random()*2 - 1,
                    1,
                    math.random()*2 - 1
                ).Unit * 20
                entity.RotVelocity = Vector3.new(
                    math.random()*2 - 1,
                    math.random()*2 - 1,
                    math.random()*2 - 1
                ).Unit * 30

                entity.BrickColor = BrickColor.new("Black")

                local physProps = PhysicalProperties.new(Enum.Material.Plastic)
                entity.CustomPhysicalProperties = physProps

                wait(1)
            end,
            step = function()
            end,
        },
    }
end