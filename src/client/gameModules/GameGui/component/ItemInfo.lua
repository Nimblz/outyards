local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Items = require(common.Items)
local Stats = require(common.Stats)

local FitList = require(component.FitList)
local FitText = require(component.FitText)

local capitalize = require(util.capitalize)

local function newLine(props)
    return Roact.createElement(FitText, {
        fitAxis = "Y",
        Size = UDim2.new(1,0,1,0),
        TextSize = props.textSize or 18,
        Font = props.font or Enum.Font.GothamSemibold,
        Text = props.text or "N/A :(",
        LayoutOrder = props.index or 99,
        TextXAlignment = props.centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
        TextYAlignment = props.centered and Enum.TextYAlignment.Center or Enum.TextYAlignment.Top,
    })
end

local damageTypePrefixes = {
    melee = "Melee ",
    ranged = "Ranged ",
    magic = "Magic ",
}

local function newSeparator(index)
    return newLine({
        text = "- - - - - - - - - - - - - -",
        centered = true,
        index = index
    })
end

return function(props)
    local itemId = props.itemId

    local item = Items.byId[itemId]

    assert(item, ("Invalid itemId %s"):format(itemId))

    local lines = {}

    lines.name = newLine({
        text = item.name,
        textSize = 24,
        font = Enum.Font.GothamBold,
        centered = true,
        index = 1,
    })

    if item.desc then
        lines.desc = newLine({
            text = item.desc,
            index = 2,
        })
    end

    if item.equipmentType then
        lines.itemType = newLine({
            text = "Type: "..capitalize(item.equipmentType),
            index = 3,
        })
    end

    lines.separator = newSeparator(4)
    local startingIndex = 4
    if item.stats then
        for idx, statType in pairs(Stats.all) do
            local index = startingIndex + idx
            local statId = statType.id
            local statValue = item.stats[statId]
            if statValue then
                local isPositive = statValue >= 0
                local namePrefix = ""

                if statType.isNormal then statValue = statValue * 100 end
                statValue = tostring(statValue)

                if statType.suffix then
                    statValue = statValue..statType.suffix
                end

                if isPositive then
                    statValue = "+"..statValue
                else
                    statValue = "-"..statValue
                end

                if statId == "baseDamage" then
                    namePrefix = damageTypePrefixes[item.stats.damageType] or ""
                end

                local newString = ("%s: %s"):format(namePrefix..statType.name, statValue)

                lines[statType.id] = newLine({
                    text = newString,
                    index = index,
                })
            end
        end
    end

    return Roact.createElement(FitList, {
        containerKind = "Frame",
        fitAxes = "Y",
        containerProps = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,0),
        },
        layoutProps = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0,4),
            FillDirection = Enum.FillDirection.Vertical,
        },
    }, lines)
end