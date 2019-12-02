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

local function aabb(props)
    local pos = props.pos
    local size = props.size
    local color = props.color or Color3.fromHSV(tick()%1,0.6,1)
    local transparency = props.transparency or 0.75
    local lifetime = props.lifetime or 1

    local newBox = Instance.new("Part")

    newBox.Material = Enum.Material.Neon
    newBox.Color = color
    newBox.Transparency = transparency
    newBox.Anchored = true
    newBox.CanCollide = false
    newBox.Size = size
    newBox.CFrame = CFrame.new(pos)
    newBox.Parent = geometryBin

    Debris:AddItem(newBox,lifetime)

    return newBox
end

local function line(props)
    error("Not yet implemented! :(")
end

local function ray(props)
    error("Not yet implemented! :(")
end

local function tri(props)
    local a = props.a
    local b = props.b
    local c = props.c

    local newFill=Instance.new('Model')
	newFill.Name='Triangle'
	local edg1=(c-a):Dot((b-a).unit)
	local edg2=(a-b):Dot((c-b).unit)
	local edg3=(b-c):Dot((a-c).unit)
	if edg1>(b-a).magnitude or edg1<0 then
		if edg2<=(c-b).magnitude and edg2>=0 then
			a,b,c=b,c,a
		elseif edg3<=(a-c).magnitude and edg3>=0 then
			a,b,c=c,a,b
		end
	end
	local len1=(c-a):Dot((b-a).unit)
	local len2=(b-a).magnitude-len1
	local width=(a+(b-a).unit*len1-c).magnitude
	local top,back=(b-a):Cross(c-b).unit,-(b-a).unit
	local right=top:Cross(back)
	local maincf=CFrame.new(a.x,a.y,a.z,
				right.x,top.x,back.x,
				right.y,top.y,back.y,
				right.z,top.z,back.z)
	local thick=1 -- min .2
	local add=(maincf*CFrame.Angles(math.pi,0,math.pi/2)*CFrame.new(thick/2,0,0)).p.magnitude<maincf.p.magnitude
	local w1=Instance.new('WedgePart',newFill)
	w1.BottomSurface='Smooth'
	w1.Anchored=true
	w1.Size=Vector3.new(thick,width,len1)
    w1.CFrame=maincf*CFrame.Angles(math.pi,0,math.pi/2)*CFrame.new(add and thick/2 or-thick/2,width/2,len1/2)
    w1.CanCollide = false
	local w2=Instance.new('WedgePart',newFill)
	w2.BottomSurface='Smooth'
	w2.Anchored=true
	w2.Size=Vector3.new(thick,width,len2)
    w2.CFrame=maincf*CFrame.Angles(math.pi,math.pi,-math.pi/2)*CFrame.new(add and-thick/2 or thick/2,width/2,-len1-len2/2)
    w2.CanCollide = false
	newFill.Parent=geometryBin
	return newFill
end

return {
    sphere = sphere,
    aabb = aabb,
    line = line,
    ray = ray,
    tri = tri,
}