local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local template = ReplicatedStorage:WaitForChild("template")
-- local util = common:WaitForChild("util")

local NPCS = require(common:WaitForChild("NPCS"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local DamageNumberSystem = RECS.System:extend("DamageNumberSystem")

local changeIndicatorTemplate = template:WaitForChild("HealthChangeIndicator")
local popInTween = TweenInfo.new(
    1,
    Enum.EasingStyle.Elastic,
    Enum.EasingDirection.Out
)

local falldownTween = TweenInfo.new(
    0.5,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.In
)

function DamageNumberSystem:spawnDamageIndicator(instance,change,fgColor,bgColor)
    local indicator = changeIndicatorTemplate:clone()
    local billboard = indicator:WaitForChild("BillboardGui")
    local fgText = billboard:WaitForChild("FGText")
    local bgText = billboard:WaitForChild("BGText")

    local offsetVec = Vector3.new(
        math.random()*2 - 1,
        math.random()*2 - 1,
        math.random()*2 - 1
    ).Unit * 3

    fgText.TextColor3 = fgColor
    fgText.TextStrokeColor3 = bgColor
    bgText.TextColor3 = bgColor
    fgText.Text = change
    bgText.Text = change

    billboard.Size = UDim2.new(0,0,0,0)

    indicator.CFrame = instance.CFrame + Vector3.new(0,instance.Size.Y/2 + 1,0) + offsetVec

    indicator.Parent = self.numbersBin

    TweenService:Create(billboard, popInTween, {
        Size = UDim2.new(2,0,2,0),
    }):Play()
    wait(1)

    TweenService:Create(billboard, falldownTween, {
        Size = UDim2.new(0,0,0,0),
        StudsOffsetWorldSpace = Vector3.new(0,-5,0),
    }):Play()
    wait(0.5)

    indicator:Destroy()
end

function DamageNumberSystem:healthChanged(instance, component, new, old)
    local healthDiff = new-old

    if healthDiff < 0 then
        local damage = math.floor(-healthDiff)
        self:spawnDamageIndicator(instance, damage, Color3.fromRGB(255, 0, 0), Color3.fromRGB(81, 0, 0))
    elseif healthDiff > 0 then
        local healing = math.floor(healthDiff)
        self:spawnDamageIndicator(instance, healing, Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 81, 0))
    end
end

function DamageNumberSystem:onComponentAdded(instance, component)
    component.changed:connect(function(prop, new, old)
        if not prop == "health" and not prop == "maxHealth" then return end
        self:healthChanged(instance, component, new, old)
    end)
end

function DamageNumberSystem:onComponentRemoving(instance,component)
    local healthbar = instance:FindFirstChild("Healthbar")
    if not healthbar then return end
    --healthbar:Destroy()
end

function DamageNumberSystem:init()
    local numbersBin = Instance.new("Folder")
    numbersBin.Name = "numbersbin"
    numbersBin.Parent = workspace
    self.numbersBin = numbersBin

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

function DamageNumberSystem:step()
end

return DamageNumberSystem