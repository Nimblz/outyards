local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local common = ReplicatedStorage:WaitForChild("common")
local event = ReplicatedStorage:WaitForChild("event")

local Sound = require(common:WaitForChild("Sound"))
local Animations = require(common:WaitForChild("Animations"))

local eAttackActor = event:WaitForChild("eAttackActor")

local behavior = {
    id = "melee"
}

function behavior:create()
    local humanoid = self.character:FindFirstChild("Humanoid")
    if not humanoid then return end
    local slashAnimation = Animations.swing
    local backSlashAnimation = Animations.backswing
    local holdAnimation = Animations.toolhold

    self.attacking = false

    local lowerTorso = self.character:WaitForChild("LowerTorso")
    local rootJoint = lowerTorso:WaitForChild("Root")
    self.rootJoint = rootJoint
    self.originalRootC0 = rootJoint.C0

    self.swingTracks = {
        humanoid:LoadAnimation(slashAnimation),
        humanoid:LoadAnimation(backSlashAnimation),
    }

    self.playingSwing = nil
    self.swingCounter = 1

    self.holdTrack = humanoid:LoadAnimation(holdAnimation)
end

function behavior:canAttack()
    local character = self.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function behavior:playSwing()
    local metadata = self.item.metadata
    local fireRate = metadata.fireRate
    local waitTime = 1/fireRate

    local track = self.swingTracks[self.swingCounter]
    local animLength = track.Length

    if self.playingSwing then self.playingSwing:Stop() end
    track:Play(0.15,1,animLength/waitTime)
    self.playingSwing = track

    self.swingCounter = self.swingCounter + 1
    if self.swingCounter > #self.swingTracks then
        self.swingCounter = 1
    end
end

function behavior:doAttack()
    if not self:canAttack() then return end

    local character = self.character
    local rootPart = character.PrimaryPart
    local lowerTorso = character:FindFirstChild("LowerTorso")
    if not lowerTorso then return end

    local rootCF = rootPart.CFrame
    local torsoCF = lowerTorso.CFrame
    local rootPosXZ = rootCF.p * Vector3.new(1,0,1)
    local facing = (torsoCF.LookVector * Vector3.new(1,0,1)).Unit

    local metadata = self.item.metadata
    local range = metadata.attackRange
    local arc = metadata.attackArc or 90

    self:playSwing()

    -- play swing sound
    if metadata.swingSound then
        Sound.playSoundAt(rootCF, Sound.presets[metadata.swingSound])
    else
        Sound.playSoundAt(rootCF, Sound.presets.slash)
    end

    -- find npcs
    local cornerOffset = (Vector3.new(1,0,1)*range) + Vector3.new(0,5,0)
    local topCorner = rootCF.p + cornerOffset
    local bottomCorner = rootCF.p - cornerOffset
    local testRegion = Region3.new(bottomCorner,topCorner)

    local parts = workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))
    local toHit = {}

    -- find monsters within our radius and arc
    for _,monster in pairs(parts) do
        -- check angle
        local mobPosXZ = monster.Position * Vector3.new(1,0,1)
        local relativePosition = mobPosXZ - rootPosXZ
        local dist = relativePosition.Magnitude
        local angle = relativePosition.Unit:Dot(facing)
        angle = math.acos(angle)

        if (dist < range and angle < math.rad(arc/2)) or (dist < 4) then
            table.insert(toHit,monster)
        end
    end

    -- play hit sound
    if #toHit > 0 then
        local hitSound = metadata.hitSound
        if hitSound then
            Sound.playSoundAt(rootCF, Sound.presets[hitSound])
        else
            Sound.playSoundAt(rootCF, Sound.presets.slash)
        end
    end

    if self.owned then
        for _,monster in pairs(toHit) do
            eAttackActor:FireServer(monster)
        end
    end
end

function behavior:activated(props)
    self.props = props

    self.attackActive = true
    if self.attacking then return end
    self.attacking = true
    while self.attackActive do
        self:doAttack()
        local fireRate = self.item.metadata.fireRate
        wait(1/fireRate)
    end
    self.attacking = false
end

function behavior:deactivated()
    self.attackActive = false
end

function behavior:recieveProps(newProps)
    self.props = newProps
end

function behavior:update()
    -- if not self.props then return end
    -- local character = self.character
    -- local root = character:FindFirstChild("HumanoidRootPart")
    -- if not root then return end

    -- local rootJoint = self.rootJoint
    -- if not rootJoint then return end

    -- local rootPos = root.Position
    -- local goalPos = self.props.mouse.worldPos

    -- local goalC0 = self.originalRootC0 * (root.CFrame - root.Position):Inverse() * CFrame.new(
    --     Vector3.new(0,0,0),
    --     (Vector3.new(goalPos.X, root.Position.Y, goalPos.Z) - rootPos).Unit
    -- )
    -- rootJoint.C0 = rootJoint.C0:lerp(goalC0, 0.1)
end

function behavior:equipped()
    self.holdTrack:play()
end

function behavior:unequipped()
    self.attackActive = false
    self.holdTrack:stop()

    self.rootJoint.C0 = self.originalRootC0
end

function behavior:destroy()
    -- for k,_ in pairs(self) do
    --     self[k] = nil
    -- end
end

return behavior