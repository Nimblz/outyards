-- TODO: clean up icky code duplication

local createNPC = require(script.Parent:WaitForChild("createNPC"))

local errors = {
    invalidMob = "Invalid NPC type [%s]!"
}

local SpawnZone = {}

local function getPartArea(part)
    return (part.Size.X * part.Size.Z)
end

local function getGroupArea(parts)
    local totalArea = 0
    for _,part in pairs(parts) do
        totalArea = totalArea + getPartArea(part)
    end
    return totalArea
end

local function getGroupRatios(parts)
	local totalArea = getGroupArea(parts)

	local ratios = {}

	for _,part in pairs(parts) do
        local area = getPartArea(part)
        local ratio = area/totalArea

        ratios[part] = ratio
	end

	return ratios
end

local function createThresholdArray(ratioTable)
    local sorted = {}

    local accumulator = 0
    for part, ratio in pairs(ratioTable) do
        table.insert(sorted,{part = part, threshold = accumulator})
        accumulator = accumulator + ratio
    end

    return sorted
end

local function getRandomPointInPart(part)
	local point = Vector3.new(math.random()*2 - 1,-1,math.random()*2 - 1)
	local pointPos = (point/2) * part.Size
	return (part.CFrame * CFrame.new(pointPos)).p
end

local function getRandomPointInGroup(parts)
    local ratios = getGroupRatios(parts)
    local thresholdArray = createThresholdArray(ratios)

    local r = math.random()
    local selectedPart

    for _,partThreshold in pairs(thresholdArray) do
        if r >= partThreshold.threshold then
            selectedPart = partThreshold.part
        else
            break
        end
    end

    return getRandomPointInPart(selectedPart)
end

local function getMobspawnThresholdArray(spawnables)
    local totalRarity = 0
    local thresholdAccumulator = 0
    local thresholds = {}

    for _, spawnable in pairs(spawnables) do
        totalRarity = totalRarity + spawnable.rarity
    end

    for _,spawnable in pairs(spawnables) do
        table.insert(thresholds, {npcType = spawnable.npcType, threshold = thresholdAccumulator})
        thresholdAccumulator = thresholdAccumulator + (spawnable.rarity/totalRarity)
    end

    return thresholds
end

local function getRandomMobToSpawn(spawnables)
    local thresholdArray = getMobspawnThresholdArray(spawnables)

    local r = math.random()
    local selectedNPC

    for _,spawnable in pairs(thresholdArray) do
        if r >= spawnable.threshold then
            selectedNPC = spawnable.npcType
        else
            break
        end
    end

    return selectedNPC
end

function SpawnZone.new(recsCore, parts, component, name)
    local self = setmetatable({},{__index = SpawnZone})

    self.entities = {}
    self.spawnParts = parts
    self.spawnables = component.spawnables
    self.spawnCap = component.spawnCap
    self.recsCore = recsCore

    self.container = Instance.new("Folder")
    self.container.Parent = workspace
    self.container.Name = name

    return self
end

function SpawnZone:getRandomPosition()
    return getRandomPointInGroup(self.spawnParts)
end

function SpawnZone:spawnNPC()
    if #self.container:GetChildren() >= self.spawnCap then return end

    local mobType = getRandomMobToSpawn(self.spawnables)
    local randomCF = CFrame.new(self:getRandomPosition())

    local newEntity = createNPC(self.recsCore, mobType, randomCF)
    newEntity.Parent = self.container
end

return SpawnZone