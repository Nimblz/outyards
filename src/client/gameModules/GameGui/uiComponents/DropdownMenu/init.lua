local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local RoundButton = require(component:WaitForChild("RoundButton"))
local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local DropdownMenu = Roact.Component:extend("DropdownMenu")

local function noop()
end

function DropdownMenu:init()
    self:setState({
        selectedIndex = 1,
        expanded = false,
    })
end

function DropdownMenu:toggle()
    self:setState(function(state)
        return {
            expanded = not state.expanded
        }
    end)
end

function DropdownMenu:render()
    local options = self.props.options
    local color = self.props.color or Color3.fromRGB(240, 240, 240)
    local defaultText = self.props.defaultText
    local expanded = self.state.expanded
    local selectedIndex = self.state.selectedIndex
    local onSelect = self.props.onSelect or noop

    local menuOptions = {}

    for index, option in ipairs(options) do
        menuOptions[option] = Roact.createElement("TextButton", {
            Text = "  "..option,
            Font = Enum.Font.GothamSemibold,
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = index,
            Size = UDim2.new(1,0,0,32),
            BorderSizePixel = 0,
            BackgroundColor3 = color,

            [Roact.Event.Activated] = function()
                self:setState({
                    selectedIndex = index
                })
                self:toggle()
                onSelect(index)
            end
        })
    end

    local menu = Roact.createElement(FitList, {
        containerKind = RoundFrame,
        fitAxes = "Y",
        containerProps = {
            Size = UDim2.new(1,0,0,0),
            Position = UDim2.new(0,0,1,4),

            color = color,

            Visible = expanded,
        },
        layoutProps = {
            Padding = UDim.new(0,4)
        },
        paddingProps = {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,0),
            PaddingRight = UDim.new(0,0),
        },
    }, menuOptions)

    local button = Roact.createElement(RoundButton, {
        Size = UDim2.new(1,0,1,0),
        color = color,
        [Roact.Event.Activated] = function()
            self:toggle()
        end
    }, {
        text = Roact.createElement("TextLabel", {
            Text = options[selectedIndex] or defaultText or "N/A",
            Font = Enum.Font.GothamSemibold,
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1,-32,1,0),
            Position = UDim2.new(0,16,0,0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        })
    })

    local frameProps = {
        Size = self.props.Size,
        Position = self.props.Position,
        AnchorPoint = self.props.AnchorPoint,
        LayoutOrder = self.props.LayoutOrder,

        BackgroundTransparency = 1,
    }

    return Roact.createElement("Frame", frameProps, {
        button = button,
        menu = menu,
    })
end

return DropdownMenu