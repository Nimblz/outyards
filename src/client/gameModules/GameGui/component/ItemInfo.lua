local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Items = require(common.Items)

local FitList = require(component.FitList)
local FitText = require(component.FitText)

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