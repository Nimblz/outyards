local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)

local FancyButton = require(component.FancyButton)
local RounderFrame = require(component.RounderFrame)

local ResponseOptions = Roact.PureComponent:extend("ResponseOptions")

local function createOption(props)
    local text = props.text
    local onClick = props.onClick
    local layoutOrder = props.layoutOrder

    local cellpadding = Roact.createElement("UIPadding", {
        PaddingBottom = UDim.new(0,8),
        PaddingTop = UDim.new(0,8),
        PaddingLeft = UDim.new(0,8),
        PaddingRight = UDim.new(0,8),
    })

    local textPadding = Roact.createElement("UIPadding", {
        PaddingBottom = UDim.new(0,4),
        PaddingTop = UDim.new(0,4),
        PaddingLeft = UDim.new(0,16),
        PaddingRight = UDim.new(0,16),
    })

    local button = Roact.createElement(FancyButton, {
        backgroundKind = RounderFrame,
        [Roact.Event.Activated] = function() onClick() end,
        Size = UDim2.new(1,0,1,0),
    }, {
        label = Roact.createElement("TextLabel", {
            Size = UDim2.new(1,0,1,0),
            Text = text,
            Font = Enum.Font.GothamSemibold,
            TextSize = 18,
            TextColor3 = Color3.new(0,0,0),
            BackgroundTransparency = 1,
        }),
        padding = textPadding,
    })

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
    }, {
        button = button,
        padding = cellpadding,
    })
end

function ResponseOptions:render()
    local options = self.props.options or {}
    local optionSelected = self.props.optionSelected
    local closeSelected = self.props.closeSelected

    local optionButtons = {}

    for index, string in ipairs(options) do
        optionButtons["option_"..index] = createOption({
            text = string,
            layoutOrder = index,
            onClick = function() optionSelected(index) end
        })
    end

    optionButtons.close = createOption({
        text = "Goodbye!",
        layoutOrder = 99,
        onClick = function() closeSelected() end
    })

    optionButtons.layout = Roact.createElement("UIGridLayout", {
        CellPadding = UDim2.new(0,0,0,0),
        CellSize = UDim2.new(0.5,0,0,64),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local optionsFrame = Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.9, 0, 0, 128),
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,1,16),
        LayoutOrder = 2,
    }, optionButtons)

    return optionsFrame
end

return ResponseOptions