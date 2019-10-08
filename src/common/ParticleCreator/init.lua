local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local particle = ReplicatedStorage:WaitForChild("particle")

local particleBin = Instance.new("Folder")
particleBin.Parent = workspace
particleBin.Name = "particles"

local ParticleCreator = {}

function ParticleCreator.spawnParticle(name, props)
    local scale = props.scale or 1
    local amount = props.amount or 1
    local cframe = props.cFrame or CFrame.new(0,0,0)
    local colorSeq = props.colorSeq

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
        emitter.Color = colorSeq or emitter.Color
    end

    -- get max possible lifetime
    for _,emitter in pairs(emitters) do
        lifetime = math.max(emitter.Lifetime.Max, lifetime)
    end

    for _, emitter in pairs(emitters) do
        emitter:Emit(amount)
    end

    Debris:AddItem(newParticle, lifetime)
end

return ParticleCreator