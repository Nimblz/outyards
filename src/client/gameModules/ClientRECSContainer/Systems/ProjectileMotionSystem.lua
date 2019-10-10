-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer

local src = script:FindFirstAncestor("server")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")
local event = ReplicatedStorage:WaitForChild("event")

local eAttackActor = event:WaitForChild("eAttackActor")

local Projectiles = require(common:WaitForChild("Projectiles"))

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local ProjectileMotionSystem = RECS.System:extend("ProjectileMotionSystem")

local PROJECTILE_LIFETIME = 4

function ProjectileMotionSystem:removeBullet(instance)
    if not instance then return end
    if not self.core:getComponent(instance,RecsComponents.Projectile) then return end
    self.core:removeComponent(instance,RecsComponents.Projectile)
    coroutine.wrap(function()
        instance.Material = Enum.Material.Air
        wait(PROJECTILE_LIFETIME)
        instance:Destroy()
    end)()
end

function ProjectileMotionSystem:onComponentAdded(instance, component)
    local projectileDesc = Projectiles.byId[component.id]
    coroutine.wrap(function()
        if projectileDesc then
            if projectileDesc.onFire then
                projectileDesc.onFire(instance,component,self.pzCore)
            end
        end
        wait(PROJECTILE_LIFETIME)
        self:removeBullet(instance)
    end)()
end

function ProjectileMotionSystem:init()
    for instance,component in self.core:components(RecsComponents.Projectile) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.Projectile):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)

    self.hittables = {
        workspace:WaitForChild("world"),
        workspace:WaitForChild("enemies"),
    }
end

function ProjectileMotionSystem:step()
    for instance,projectile in self.core:components(RecsComponents.Projectile) do
        projectile.velocity = projectile.velocity - Vector3.new(0,Workspace.Gravity*(1/60)*projectile.gravityScale,0)
        local projectileDesc = Projectiles.byId[projectile.id]
        -- hit test
        local hit, pos, norm = Workspace:FindPartOnRayWithWhitelist(Ray.new(
            projectile.position,
            projectile.velocity * 1/60
        ), self.hittables)

        if hit then
            self:removeBullet(instance)

            if projectileDesc.onHit then
                projectileDesc.onHit(instance, projectile, self.pzCore, hit, pos, norm)
            end
        end

        projectile.position = projectile.position + (projectile.velocity * (1/60))

        instance.CFrame = CFrame.new(projectile.position, projectile.position + projectile.velocity.Unit)

        if projectile.position.y < -500 then
            self:removeBullet(instance)
        end
    end
end

return ProjectileMotionSystem