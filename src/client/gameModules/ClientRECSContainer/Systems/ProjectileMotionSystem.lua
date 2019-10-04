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

local Items = require(common:WaitForChild("Items"))
local Actions = require(common:WaitForChild("Actions"))

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
    coroutine.wrap(function()
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
end

function ProjectileMotionSystem:step()
    for instance,projectile in self.core:components(RecsComponents.Projectile) do
        projectile.velocity = projectile.velocity - Vector3.new(0,Workspace.Gravity*(1/60)*projectile.gravityScale,0)

        -- hit test
        local hit = Workspace:FindPartOnRayWithIgnoreList(Ray.new(
            projectile.position,
            projectile.velocity * 1/60
        ), {workspace:FindFirstChild("bullets")})

        if hit then
            self:removeBullet(instance)

            -- if its an enemy do damage
            if CollectionService:HasTag(hit,"ActorStats") then
                eAttackActor:FireServer(hit)
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