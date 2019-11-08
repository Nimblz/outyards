local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local eAttackActor = event.eAttackActor

local Projectiles = require(common.Projectiles)

local PizzaAlpaca = require(lib.PizzaAlpaca)

local ProjectileCreator = PizzaAlpaca.GameModule:extend("ProjectileCreator")

function ProjectileCreator:fireProjectile(owner, id, origin, direction, metadata)
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
        owner = owner,
        fireTime = tick(),
        metadata = metadata
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