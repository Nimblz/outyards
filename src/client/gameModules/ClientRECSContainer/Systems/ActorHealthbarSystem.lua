local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local template = ReplicatedStorage:WaitForChild("template")
-- local util = common:WaitForChild("util")

local healthbarTemplate = template:WaitForChild("Healthbar")
local healthTween = TweenInfo.new(
    0.1,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

local NPCS = require(common:WaitForChild("NPCS"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local ActorHealthbarSystem = RECS.System:extend("ActorHealthbarSystem")



function ActorHealthbarSystem:onComponentChange(instance, component)
    local healthbar = instance:FindFirstChild("Healthbar")
    if not healthbar then return end
    local redFrame = healthbar:WaitForChild("redFrame")
    local greenFrame = redFrame:WaitForChild("greenFrame")
    local nameLabel = healthbar:WaitForChild("nameLabel")
    local healthLabel = healthbar:WaitForChild("healthLabel")

    local health = math.max(component.health,0)
    local maxHealth = component.maxHealth

    if health/maxHealth >= 1 then
        healthbar.Enabled = false
        return
    else
        healthbar.Enabled = true
        local npcComponent = self.core:getComponent(instance, RecsComponents.NPC)
        if npcComponent then
            local npcDesc = NPCS.byType[npcComponent.npcType]
            nameLabel.Text = npcDesc.name or "???"
        else
            nameLabel.Text = "???"
        end
        healthLabel.Text = "  "..tostring(math.ceil(health)).." / "..tostring(math.floor(maxHealth))
        local targetProps = {
            Size = UDim2.new(health/component.maxHealth,0,1,0)
        }

        local newTween = TweenService:Create(greenFrame,healthTween,targetProps, true)
        newTween:Play()
    end
end

function ActorHealthbarSystem:onComponentAdded(instance, component)
    -- on component add create a bodyvelocity bodyforce and bodygyro
    local healthbar = healthbarTemplate:clone()

    component.changed:connect(function(prop, new, old)
        if not prop == "health" and not prop == "maxHealth" then return end
        self:onComponentChange(instance, component)
    end)

    healthbar.Parent = instance
    healthbar.StudsOffsetWorldSpace = Vector3.new(0,instance.Size.Y/2 + 1, 0)

    self:onComponentChange(instance,component)
end

function ActorHealthbarSystem:onComponentRemoving(instance,component)
    local healthbar = instance:FindFirstChild("Healthbar")
    if not healthbar then return end
    --healthbar:Destroy()
end

function ActorHealthbarSystem:init()
    for instance,component in self.core:components(RecsComponents.ActorStats) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.ActorStats):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.ActorStats):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function ActorHealthbarSystem:step()
end

return ActorHealthbarSystem