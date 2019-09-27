local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerMouse = LocalPlayer:GetMouse()

local common = ReplicatedStorage:WaitForChild("common")
--local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Selectors = require(common:WaitForChild("Selectors"))

local eAttackActor = event:WaitForChild("eAttackActor")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PrototypeMelee = PizzaAlpaca.GameModule:extend("PrototypeMelee")

--local debouncer = require(util:WaitForChild("debouncer"))

function PrototypeMelee:create()
    self.attackRadius = 8
    self.attackRate = 1
    self.autoAttack = false
end

function PrototypeMelee:onStore(store)
    store.changed:connect(function(newState,oldState)
        local attackRate = Selectors.getAttackRate(newState,LocalPlayer)
        local autoAttack = Selectors.getAutoAttack(newState,LocalPlayer)
        self.attackRate = attackRate
        self.autoAttack = autoAttack
    end)
end

function PrototypeMelee:init()
    local inputHandler = self.core:getModule("InputHandler")
    local storeContainer = self.core:getModule("StoreContainer")
    local attack = inputHandler:getActionSignal("attack")

    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)

    local currentAttack = nil
    attack.began:connect(function(input)
        if currentAttack then return currentAttack:resume() end
        currentAttack = {}

        local attacking = true
        currentAttack.cancel = function()
            attacking = false
        end
        currentAttack.resume = function()
            attacking = true
        end

        repeat
            self:onAttack()
            wait(1/self.attackRate)
        until not attacking or not self.autoAttack

        currentAttack = nil
    end)

    attack.ended:connect(function(input)
        if not currentAttack then return end
        currentAttack:cancel()
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
    attackVis.Transparency = 0.75
    attackVis.Size = Vector3.new(1,1,1) * self.attackRadius*2
    attackVis.CFrame = targetCFrame
    attackVis.Shape = Enum.PartType.Ball

    attackVis.Parent = workspace

    -- find npcs
    local cornerOffset = Vector3.new(1,1,1)*self.attackRadius
    local topCorner = targetCFrame.p + cornerOffset
    local bottomCorner = targetCFrame.p - cornerOffset
    local testRegion = Region3.new(bottomCorner,topCorner)

    local parts = Workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

    for _,v in pairs(parts) do
        eAttackActor:FireServer(v)
    end

    delay(3/20,function()
        attackVis:Destroy()
    end)
end

return PrototypeMelee