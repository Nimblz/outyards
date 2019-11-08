local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local common = ReplicatedStorage.common
local util = common.util
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)

local getAppliedScale = require(util.getAppliedScale)

local FitList = require(component.FitList)
local FitText = require(component.FitText)
local Tooltip = Roact.PureComponent:extend("Tooltip")

function Tooltip:init()
    self.containerRef = Roact.createRef()

    self:setState({
        position = Vector2.new(0,0)
    })
end

function Tooltip:didMount()
    self.steppedConnection = RunService.RenderStepped:Connect(function()
        self:setState({
            position = UserInputService:GetMouseLocation() - GuiService:GetGuiInset() + Vector2.new(20,20),
            scale = getAppliedScale(self.containerRef:getValue()),
            size = self.containerRef:getValue().AbsoluteSize,
        })
    end)

    self:setState(function()
        return {
            position = UserInputService:GetMouseLocation() - GuiService:GetGuiInset() + Vector2.new(20,20),
            scale = getAppliedScale(self.containerRef:getValue()),
            size = self.containerRef:getValue().AbsoluteSize,
        }
    end)
end

function Tooltip:willUnmount()
    if self.steppedConnection then self.steppedConnection:Disconnect() end
end

function Tooltip:render()
    local screenSize = self.props.screenSize
    local strings = self.props.strings
    local visible = self.props.visible
    local scale = self.state.scale or 1
    local size = self.state.size or Vector2.new(0, 0)
    local position = Vector2.new(
        math.max(math.min(self.state.position.X,screenSize.X - (size.X+4+16)),16),
        math.max(math.min(self.state.position.Y,screenSize.Y - (size.Y+4+16)),16)
    ) / scale

    local children = {}

    for index,string in ipairs(strings) do
        if string == "$SEPARATOR" then
            children[index.."_label"] = Roact.createElement(FitText, {
                Text = ("- "):rep(20):sub(1,39),
                BackgroundTransparency = 1,
                TextSize = 18,
                Font = index == 1 and Enum.Font.GothamBlack or Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = index,
                TextColor3 = Color3.fromRGB(0,0,0),
                TextWrapped = true,

                fitAxis = "X",
                Size = UDim2.new(0,235,0,18),
            })
        else
            children[index.."_label"] = Roact.createElement(FitText, {
                Text = string,
                BackgroundTransparency = 1,
                TextSize = index == 1 and 24 or 18,
                Font = index == 1 and Enum.Font.GothamBlack or Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = index,
                TextColor3 = Color3.fromRGB(0,0,0),
                TextWrapped = true,

                fitAxis = "Y",
                Size = UDim2.new(0,235,0,18),
            })
        end
    end

    local listFrame = Roact.createElement(FitList, {
        containerProps = {
            Position = UDim2.new(0,position.X,0,position.Y),

            BackgroundColor3 = Color3.new(1,1,1),
            BorderSizePixel = 0,

            Visible = visible,

            ZIndex = 5,
            [Roact.Ref] = self.containerRef
        },
        layoutProps = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,4),
            FillDirection = Enum.FillDirection.Vertical,
        },
        paddingProps = {
            PaddingTop = UDim.new(0,4),
            PaddingBottom = UDim.new(0,4),
            PaddingLeft = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
        }
    }, children)

    local shadowFrame = Roact.createElement("Frame", {
        Size = UDim2.new(0, size.X, 0, size.Y),
        Position = UDim2.new(0,position.X + 4,0,position.Y + 4),

        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderSizePixel = 0,

        Visible = visible,
        ZIndex = 4,
    })

    return Roact.createFragment({
        shadowFrame = shadowFrame,
        listFrame = listFrame,
    })
end

local function mapStateToProps(state,props)
    return {
        visible = Selectors.getTooltipVisible(state) or false,
        strings = Selectors.getTooltipStrings(state) or {},
        screenSize = Selectors.getScreenSize(state),
    }
end

Tooltip = RoactRodux.connect(mapStateToProps)(Tooltip)

return Tooltip