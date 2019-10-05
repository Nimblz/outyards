local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local common = ReplicatedStorage:WaitForChild("common")

local ParticleCreator = require(common:WaitForChild("ParticleCreator"))
local NPCS = require(common:WaitForChild("NPCS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local errors = {
    invalidMob = "Invalid NPC type [%s]!"
}

return function(recsCore, npcType, cframe)
    local mobDesc = NPCS.byType[npcType]
    assert(mobDesc, errors.invalidMob:format(npcType))

    local NewNPCPart = Instance.new("Part")
    NewNPCPart.CastShadow = false
    NewNPCPart.TopSurface = Enum.SurfaceType.Smooth
    NewNPCPart.BottomSurface = Enum.SurfaceType.Smooth
    NewNPCPart.Size = mobDesc.boundingBoxProps.Size
    NewNPCPart.Color= mobDesc.boundingBoxProps.Color
    NewNPCPart.CFrame = cframe * CFrame.new(0,(NewNPCPart.Size.Y/2), 0)

    local Decal = Instance.new("Decal")
    Decal.Texture = "rbxassetid://23912218"
    Decal.Parent = NewNPCPart

    local physProps = PhysicalProperties.new(1,0,0.5,100,100)
    NewNPCPart.CustomPhysicalProperties = physProps

    NewNPCPart.Parent = workspace

    recsCore:addComponent(NewNPCPart,RecsComponents.NPC, {npcType = npcType})

    ParticleCreator.spawnParticle("smoke", NewNPCPart.CFrame, 1, 6)

    return NewNPCPart
end