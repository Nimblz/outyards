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
                local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, actorStats.attackRange)

                if closeEnoughToAttack then
                    driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
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
                driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
                props.target = target

                local debounce = false

                local function attack()
                    if debounce then return end
                    debounce = true

                    local target = props.target
                    local targetRoot = target.PrimaryPart
                    local selfPos = entity.Position
                    local lookVec = entity.CFrame.lookVector

                    local attackRay = Ray.new(selfPos,lookVec*actorStats.attackRange)

                    local hit = Workspace:FindPartOnRayWithIgnoreList(attackRay, CollectionService:GetTagged("NPCDriver"))
                    if hit then
                        local humanoid = hit.Parent:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid:TakeDamage(actorStats.baseDamage)
                        end
                    end

                    -- debug vis

                    local vis = Instance.new("Part")
                    vis.Anchored = true
                    vis.CanCollide = false
                    vis.CastShadow = false
                    vis.Material = Enum.Material.Neon
                    vis.BrickColor = BrickColor.new("Bright red")
                    vis.Transparency = 0.75
                    vis.Size = Vector3.new(1,1/3,actorStats.attackRange)
                    vis.CFrame = CFrame.new(selfPos,selfPos+lookVec) * CFrame.new(0,0,-actorStats.attackRange/2)
                    vis.Parent = workspace

                    delay(1/10, function() vis:Destroy() end)

                    wait(1/actorStats.attackRate)
                    debounce = false
                end

                props.attack = attack
            end,
            step = function()
                if props.attack then
                    coroutine.wrap(props.attack)()
                end

                local target = props.target
                local targetRoot = target.PrimaryPart
                local selfPosXZ = entity.Position * Vector3.new(1,0,1)
                local targetPosXZ = targetRoot.Position * Vector3.new(1,0,1)
                local targetMoveDir = (targetPosXZ-selfPosXZ).unit
                local closeEnoughToAttack = pointsCloserThan(selfPosXZ,targetPosXZ, actorStats.attackRange)

                driver:updateProperty("targetDirection", CFrame.new(selfPosXZ,targetPosXZ).lookVector)
                if not closeEnoughToAttack then
                    return "chase", target
                end
            end,
            leaving = function()
                props.target = nil
            end
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