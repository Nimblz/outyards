local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PrototypeAttack = PizzaAlpaca.GameModule:extend("PrototypeAttack")

function PrototypeAttack:create()
    self.attackRadius = 8
end

function PrototypeAttack:preInit()
end

function PrototypeAttack:init()
    local InputHandler = self.core:getModule("InputHandler")
    local attacked = InputHandler:getActionSignal("attack")

    attacked:connect(function(input)
        self:onAttack()
    end)
end

function PrototypeAttack:postInit()
end

function PrototypeAttack:canAttack()
    local character = LocalPlayer.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function PrototypeAttack:onAttack()
    if not self:canAttack() then return end

    local character = LocalPlayer.Character
    local rootPart = character.PrimaryPart
    local targetCFrame = CFrame.new(rootPart.Position)

    local attackVis = Instance.new("Part")
    attackVis.Anchored = true
    attackVis.CanCollide = false
    attackVis.Material = Enum.Material.Neon
    attackVis.BrickColor = BrickColor.new("Bright red")
    attackVis.Transparency = 0.75
    attackVis.Size = Vector3.new(1,1,1) * self.attackRadius*2
    attackVis.CFrame = targetCFrame

    attackVis.Parent = workspace

    delay(1,function()
        attackVis:Destroy()
    end)
end

return PrototypeAttack