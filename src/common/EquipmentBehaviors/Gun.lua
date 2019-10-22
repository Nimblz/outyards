local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Trajectory = require(util:WaitForChild("Trajectory"))
local Projectiles = require(common:WaitForChild("Projectiles"))
local Sound = require(common:WaitForChild("Sound"))
local Animations = require(common:WaitForChild("Animations"))

local behavior = {
    id = "gun"
}

function behavior:canAttack()
    local character = self.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function behavior:create()
    local humanoid = self.character:FindFirstChild("Humanoid")
    if not humanoid then return end

    local holdAnimation = Animations.toolhold

    self.attacking = false
    self.projectileCreator = self.pzCore:getModule("ProjectileCreator")

    self.metadata = self.item.metadata or {}

    self.holdTrack = humanoid:LoadAnimation(holdAnimation)
end

function behavior:activated(props)
    self.props = props

    local metadata = self.metadata

    self.attackActive = true
    if self.attacking then return end
    self.attacking = true
    while self.attackActive do
        self:doAttack()
        local fireRate = metadata.fireRate or 3
        wait(1/fireRate)
    end
    self.attacking = false
end

function behavior:shootBullet(origin,directionGoal)
    local metadata = self.metadata
    local projectileMetadata
    if metadata then
        projectileMetadata = metadata.projectileMetadata or {}
    end

    local projectileType = metadata.projectileType or "bullet"
    local deviation = metadata.projectileDeviation or 0

    -- calc bullet direction (INNACURACY IS PER-CLIENT)
    local directionCF = CFrame.new(Vector3.new(0,0,0),directionGoal)
    directionCF = directionCF * CFrame.fromAxisAngle(
        Vector3.new(math.random()*2 - 1,math.random()*2 - 1,math.random()*2 - 1).Unit,
        math.random() * math.rad(deviation)
    )
    local direction = directionCF.LookVector

    self.projectileCreator:fireProjectile(self.player, projectileType, origin.p, direction, projectileMetadata)
end

function behavior:doAttack()
    if not self:canAttack() then return end
    local character = self.character
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local metadata = self.metadata

    local projectileType = metadata.projectileType or "bullet"
    local projectile = Projectiles.byId[projectileType]

    -- calculate a bunch of positions
    local down = Vector3.new(0,-1,0)
    local goalPos = self.props.mouse.worldPos
    local rootPos = root.Position
    local rootPosXZ = rootPos * Vector3.new(1,0,1)
    local mousePosXZ = goalPos * Vector3.new(1,0,1)
    local faceFec = (mousePosXZ-rootPosXZ).unit
    local originCFrame = CFrame.new(Vector3.new(0,0,0), faceFec) * CFrame.new(0,0,-5)
    originCFrame = originCFrame + rootPos
    local relativeGoalPos = goalPos-originCFrame.p

    local goalAngle = math.deg(math.acos(relativeGoalPos.Unit:Dot(down))) - 90
    goalAngle = math.max(goalAngle,45)

    local bulletSpeed = projectile.speed
    local bulletGravity = Workspace.Gravity * projectile.gravityScale
    local direction = Trajectory.directionToReachGoal(originCFrame.p, goalPos, bulletSpeed, bulletGravity)
    if not direction then direction = Trajectory.towardsWithAngle(originCFrame.p, goalPos, math.rad(goalAngle)) end

    Sound.playSoundAt(originCFrame, Sound.presets[metadata.shootSound or "gunshot"])

    for _ = 1, metadata.projectileCount or 1 do
        self:shootBullet(originCFrame,direction)
    end
end

function behavior:deactivated()
    self.attackActive = false
end

function behavior:recieveProps(inputProps)
    self.props = inputProps
end

function behavior:update()
end

function behavior:equipped()
    self.holdTrack:play()
end

function behavior:unequipped()
    self.attackActive = false
    self.holdTrack:stop()
end

function behavior:destroy()
end

return behavior