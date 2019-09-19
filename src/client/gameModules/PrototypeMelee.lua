local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--local common = ReplicatedStorage:WaitForChild("common")
--local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PrototypeMelee = PizzaAlpaca.GameModule:extend("PrototypeMelee")

--local debouncer = require(util:WaitForChild("debouncer"))

function PrototypeMelee:create()
    self.attackRadius = 12
    self.attackRate = 1
    self.autoAttack = false
end

function PrototypeMelee:preInit()
end

function PrototypeMelee:init()
    local InputHandler = self.core:getModule("InputHandler")
    local attack = InputHandler:getActionSignal("attack")

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
    local targetCFrame = CFrame.new(rootPart.Position)

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

    delay(3/20,function()
        attackVis:Destroy()
    end)
end

return PrototypeMelee