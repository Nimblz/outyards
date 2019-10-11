local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local geometryBin = Instance.new("Folder")
geometryBin.Name = "debuggeometry"
geometryBin.Parent = Workspace

local function sphere(props)
    local origin = props.origin or Vector3.new(0,0,0)
    local radius = props.radius or 1
    local color = props.color or Color3.fromHSV(tick()%1,0.6,1)
    local transparency = props.transparency or 0.75
    local lifetime = props.lifetime or 1

    local part = Instance.new("Part")
    part.CastShadow = false
    part.Anchored = true
    part.CanCollide = false
    part.Size = Vector3.new(1,1,1)*radius*2
    part.CFrame = CFrame.new(origin)
    part.Transparency = transparency
    part.Color = color
    part.Shape = Enum.PartType.Ball
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Material = Enum.Material.Neon

    part.Parent = geometryBin

    Debris:AddItem(part,lifetime)

    return part
end

local function box(props)
    error("Not yet implemented! :(")
end

local function line(props)
    error("Not yet implemented! :(")
end

local function ray(props)
    error("Not yet implemented! :(")
end

return {
    sphere = sphere,
    box = box,
    line = line,
    ray = ray,
}