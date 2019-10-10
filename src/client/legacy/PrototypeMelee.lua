local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerMouse = LocalPlayer:GetMouse()

local common = ReplicatedStorage:WaitForChild("common")
--local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Selectors = require(common:WaitForChild("Selectors"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PrototypeMelee = PizzaAlpaca.GameModule:extend("PrototypeMelee")

local eAttackActor = event:WaitForChild("eAttackActor")

local explosionTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function PrototypeMelee:create()
    self.attackRadius = 8
    self.attackRate = 1
    self.autoAttack = false
end

function PrototypeMelee:onStore(store)
    store.changed:connect(function(newState,oldState)
        local attackRate = Selectors.getAttackRate(newState,LocalPlayer)
        self.attackRate = attackRate
    end)
end

function PrototypeMelee:init()
    local inputHandler = self.core:getModule("InputHandler")
    local storeContainer = self.core:getModule("StoreContainer")
    local attack = inputHandler:getActionSignal("attack")

    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)

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

function PrototypeMelee:postInit()
end

function PrototypeMelee:canAttack()
    local character = LocalPlayer.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function PrototypeMelee:onAttack()
    if not self:canAttack() then return end

    local character = LocalPlayer.Character
    local rootPart = character.PrimaryPart
    local rootPos = rootPart.Position
    local rootPosXZ = rootPos * Vector3.new(1,0,1)
    local mousePosXZ = PlayerMouse.hit.p * Vector3.new(1,0,1)
    local faceFec = (mousePosXZ-rootPosXZ).unit
    local targetCFrame = CFrame.new(Vector3.new(0,0,0), faceFec) * CFrame.new(0,0,-self.attackRadius*0.75)
    targetCFrame = targetCFrame + rootPos

    local attackVis = Instance.new("Part")
    attackVis.Anchored = true
    attackVis.CanCollide = false
    attackVis.CastShadow = false
    attackVis.Material = Enum.Material.Neon
    attackVis.BrickColor = BrickColor.new("Bright red")
    attackVis.Transparency = 0.5
    attackVis.Size = Vector3.new(1,1,1) * self.attackRadius*1.1
    attackVis.CFrame = targetCFrame
    attackVis.Shape = Enum.PartType.Ball

    local attackVis2 = Instance.new("Part")
    attackVis2.Anchored = true
    attackVis2.CanCollide = false
    attackVis2.CastShadow = false
    attackVis2.Material = Enum.Material.Neon
    attackVis2.BrickColor = BrickColor.new("White")
    attackVis2.Transparency = 0.5
    attackVis2.Size = Vector3.new(1,1,1) * self.attackRadius*1
    attackVis2.CFrame = targetCFrame
    attackVis2.Shape = Enum.PartType.Ball

    attackVis.Parent = LocalPlayer.Character
    attackVis2.Parent = LocalPlayer.Character

    TweenService:Create(attackVis,explosionTweenInfo, {
        Size = Vector3.new(1,1,1) * self.attackRadius*3,
        Transparency = 1,
    }):Play()

    TweenService:Create(attackVis2,explosionTweenInfo, {
        Size = Vector3.new(1,1,1) * self.attackRadius*1.5,
        Transparency = 1,
    }):Play()

    delay(0.1,function()
        attackVis2:Destroy()
    end)

    -- find npcs
    local cornerOffset = Vector3.new(1,1,1)*self.attackRadius
    local topCorner = targetCFrame.p + cornerOffset
    local bottomCorner = targetCFrame.p - cornerOffset
    local testRegion = Region3.new(bottomCorner,topCorner)

    local parts = Workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

    for _,v in pairs(parts) do
        eAttackActor:FireServer(v)
    end

    delay(0.3,function()
        attackVis:Destroy()
    end)
end

return PrototypeMelee