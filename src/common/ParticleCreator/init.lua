local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local particle = ReplicatedStorage.particle

local particleBin = Instance.new("Folder")
particleBin.Parent = Workspace
particleBin.Name = "particles"

local ParticleCreator = {}

function ParticleCreator.spawnParticle(name, props)
    local scale = props.scale or 1
    local amount = props.amount or 1
    local timeScale = props.timeScale or 1
    local cframe = props.cFrame or CFrame.new(0,0,0)
    local color = props.color

    timeScale = 1/timeScale

    local sourceParticleModel = particle:FindFirstChild(name)
    if not sourceParticleModel then return end

    local newParticle = sourceParticleModel:Clone()
    newParticle.Parent = particleBin
    newParticle.CFrame = cframe

    local emitters = {}
    local lifetime = 0

    for _,child in pairs(newParticle:GetDescendants()) do
        if child:IsA("ParticleEmitter") then
            table.insert(emitters,child)
        end
    end

    -- set scales
    for _,emitter in pairs(emitters) do
        local newKeypoints = {}
        for idx,keypoint in ipairs(emitter.Size.Keypoints) do
            newKeypoints[idx] = NumberSequenceKeypoint.new(
                keypoint.Time,
                keypoint.Value * scale,
                keypoint.Envelope * scale
            )
        end
        emitter.Size = NumberSequence.new(newKeypoints)
    end

    -- set color
    for _,emitter in pairs(emitters) do
        emitter.Color = color or emitter.Color
    end

    -- get max possible lifetime
    for _,emitter in pairs(emitters) do
        emitter.Lifetime = NumberRange.new(emitter.Lifetime.Min * timeScale, emitter.Lifetime.Max * timeScale)
        lifetime = math.max(emitter.Lifetime.Max, lifetime)
    end

    for _, emitter in pairs(emitters) do
        emitter:Emit(amount)
    end

    Debris:AddItem(newParticle, lifetime)
end

return ParticleCreator