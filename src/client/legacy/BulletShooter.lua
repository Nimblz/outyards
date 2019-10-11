local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerMouse = LocalPlayer:GetMouse()

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")

local Trajectory = require(util:WaitForChild("Trajectory"))
local Selectors = require(common:WaitForChild("Selectors"))
local Projectiles = require(common:WaitForChild("Projectiles"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Sound = require(common:WaitForChild("Sound"))

local BulletShooter = PizzaAlpaca.GameModule:extend("BulletShooter")

local function camRayFromMousePos(mousePos)
    local cam = Workspace.CurrentCamera
    if not cam then return end

    return cam:ScreenPointToRay(mousePos.X,mousePos.Y,1)
end

function BulletShooter:onStore(store)
    store.changed:connect(function(newState,oldState)
        local attackRate = Selectors.getAttackRate(newState,LocalPlayer)
        self.attackRate = 10
    end)
end

function BulletShooter:create()
    self.bulletsPerAttack = 3
    self.attackRate = 10
end

function BulletShooter:init()
    self.inputHandler = self.core:getModule("InputHandler")
    local attack = self.inputHandler:getActionSignal("attack")

    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)

    self.projectileCreator = self.core:getModule("ProjectileCreator")

    self.bulletBin = workspace:WaitForChild("bullets")

    local attacking = false

    attack.began:connect(function(input)
        if attacking then return end
        attacking = true
        while attack.isActive do
            self:onAttack()
            wait(1/self.attackRate)
        end
        attacking = false
    end)
end

function BulletShooter:canAttack()
    local character = LocalPlayer.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function BulletShooter:shootBullet(origin,directionGoal)
    local directionCF = CFrame.new(Vector3.new(0,0,0),directionGoal)
    directionCF = directionCF * CFrame.fromAxisAngle(
        Vector3.new(math.random()*2 - 1,math.random()*2 - 1,math.random()*2 - 1).Unit,
        math.random() * math.rad(4)
    ) * CFrame.new(0,0,-1)

    local direction = directionCF.p

    self.projectileCreator:fireProjectile(LocalPlayer,"bullet", origin.p, direction)
end

function BulletShooter:onAttack()
    if not self:canAttack() then return end
    local character = LocalPlayer.Character
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local camRay = camRayFromMousePos(self.inputHandler:getMousePos())
    local hit,goalPos,norm = Workspace:FindPartOnRayWithIgnoreList(
        Ray.new(camRay.Origin,camRay.Direction*512),
        {character, self.bulletBin}
    )

    local rootPos = root.Position
    local rootPosXZ = rootPos * Vector3.new(1,0,1)
    local mousePosXZ = goalPos * Vector3.new(1,0,1)
    local faceFec = (mousePosXZ-rootPosXZ).unit
    local targetCFrame = CFrame.new(Vector3.new(0,0,0), faceFec) * CFrame.new(0,0,-5)
    targetCFrame = targetCFrame + rootPos

    local bulletSpeed = Projectiles.byId["bullet"].speed
    local bulletGravity = Workspace.Gravity * Projectiles.byId["bullet"].gravityScale
    local direction = Trajectory.directionToReachGoal(targetCFrame.p, goalPos, bulletSpeed, bulletGravity)
    if not direction then direction = goalPos - targetCFrame.p end

    Sound.playSoundAt(targetCFrame, Sound.presets.gunshot)

    for i = 1, self.bulletsPerAttack do
        self:shootBullet(targetCFrame,direction)
    end
end

return BulletShooter