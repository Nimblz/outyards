local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local eAttackActor = event:WaitForChild("eAttackActor")

local Projectiles = require(common:WaitForChild("Projectiles"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ProjectileCreator = PizzaAlpaca.GameModule:extend("ProjectileCreator")

function ProjectileCreator:fireProjectile(owner, id, origin, direction)
    if not self.recsCore then return end
    local model = Projectiles.getModelForId(id)
    local projectile = Projectiles.byId[id]

    if not model then return end
    if not projectile then return end

    local newBullet = model:clone()

    newBullet.Parent = self.bulletBin
    newBullet.CFrame = CFrame.new(origin,origin+(direction.Unit))

    self.recsCore:addComponent(newBullet,self.recsCore:getComponentClass("Projectile"), {
        id = id,
        position = origin,
        velocity = direction.Unit * projectile.speed,
        gravityScale = projectile.gravityScale,
        fireTime = tick(),
    })
end

function ProjectileCreator:preInit()
    local bulletBin = Instance.new("Folder")
    bulletBin.Name = "bullets"
    bulletBin.Parent = workspace
    self.bulletBin = bulletBin
end

function ProjectileCreator:postInit()
    local recsContainer = self.core:getModule("ClientRECSContainer")
    recsContainer:getCore():andThen(function(newCore)
        self.recsCore = newCore
    end)
end

return ProjectileCreator