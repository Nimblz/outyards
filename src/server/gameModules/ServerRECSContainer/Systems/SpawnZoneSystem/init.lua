-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer
local PhysicsService = game:GetService("PhysicsService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local SpawnZone = require(script:WaitForChild("SpawnZone"))

local SpawnZoneSystem = RECS.System:extend("SpawnZoneSystem")

function SpawnZoneSystem:spawnNPC(zoneInstance)
    local spawnZone = self.spawnZones[zoneInstance]

    spawnZone:spawnNPC()
end

function SpawnZoneSystem:onComponentAdded(instance, component)

    local spawnZoneParts = {}

    for _,child in pairs(instance:GetDescendants()) do
        if child:IsA("Part") then
            table.insert(spawnZoneParts,child)
        end
    end

    local newSpawnZone = SpawnZone.new(
        self.core,
        spawnZoneParts,
        component,
        instance.Name.."_spawnContainer"
    )
    wait(1)
    for _ = 1, component.spawnCap do
        newSpawnZone:spawnNPC()
        wait()
    end

    self.spawnZones[instance] = newSpawnZone
end

function SpawnZoneSystem:onComponentRemoving(instance,component)
end

function SpawnZoneSystem:init()
    local enemiesBin = workspace:FindFirstChild("enemies")
    if not enemiesBin then
        enemiesBin = Instance.new("Folder")
        enemiesBin.Name = "enemies"
        enemiesBin.Parent = workspace
    end

    self.spawnZones = {}

    for instance,component in self.core:components(RecsComponents.SpawnZone) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.SpawnZone):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.SpawnZone):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function SpawnZoneSystem:step()
    -- loop thru each spawn zone and spawn npcs if counter is at/over rate

    for instance,zoneComponent in self.core:components(RecsComponents.SpawnZone) do
        zoneComponent.counter = zoneComponent.counter + 1
        if zoneComponent.counter >= zoneComponent.spawnRate then
            self:spawnNPC(instance)
            zoneComponent.counter = 0
        end
    end
end

return SpawnZoneSystem