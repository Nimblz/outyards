local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")
local model = ReplicatedStorage:WaitForChild("model")
local npcModel = model:WaitForChild("npc")

local NPCS = require(common:WaitForChild("NPCS"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local ActorRigSystem = RECS.System:extend("ActorRigSystem")

-- local function fakeWeld(part1, part2)
-- 	--Check if HumanoidRootPart exists
-- 	local a0 = part1:FindFirstChild("Attachment") or Instance.new("Attachment")
--     local a1 = part2:FindFirstChild("Attachment") or Instance.new("Attachment")
-- 	local alignP = Instance.new("AlignPosition")
-- 	local alignO = Instance.new("AlignOrientation")

-- 	alignP.Attachment0 = a1 --local char
-- 	alignP.Attachment1 = a0
--     alignP.RigidityEnabled = true
--     alignP.ReactionForceEnabled = false
-- 	alignO.Attachment0 = a1 --local char
-- 	alignO.Attachment1 = a0
--     alignO.RigidityEnabled = true
--     alignO.ReactionTorqueEnabled = false

--     a0.Parent = part1
--     a1.Parent = part2
-- 	alignO.Parent = part1
-- 	alignP.Parent = part1
-- end

function ActorRigSystem:onComponentAdded(instance, component)
    local npcComponent = self.core:getComponent(instance, RecsComponents.NPC)
    if not npcComponent then return end

    local rig = npcModel:FindFirstChild(npcComponent.npcType)
    if not rig then return end
    rig = rig:Clone()
    rig.PrimaryPart.Anchored = false
    rig:SetPrimaryPartCFrame(instance.CFrame)

    local weld = Instance.new("Weld")
    weld.Part0 = rig.PrimaryPart
    weld.Part1 = instance
    weld.Parent = rig.PrimaryPart

    rig.Parent = self.rigBin
    rig.PrimaryPart:SetNetworkOwner()

    self.rigs[instance] = rig

    instance.Transparency = 1
end

function ActorRigSystem:onComponentRemoving(instance,component)
    local rig = self.rigs[instance]
    if rig then rig:Destroy() end
end

function ActorRigSystem:init()
    self.rigBin = Instance.new("Folder")
    self.rigBin.Name = "rigbin"
    self.rigBin.Parent = workspace

    self.rigs = {}

    for instance,component in self.core:components(RecsComponents.AI) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function ActorRigSystem:step()
end

return ActorRigSystem