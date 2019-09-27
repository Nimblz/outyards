local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))

local Tooltip = Roact.Component:extend("Tooltip")

function Tooltip:init()
    self:setState({
        position = Vector2.new(0,0)
    })
end

function Tooltip:didMount()
    self.steppedConnection = RunService.RenderStepped:connect(function()
        self:setState({
            position = UserInputService:GetMouseLocation() - GuiService:GetGuiInset() + Vector2.new(20,20)
        })
    end)
end

function Tooltip:willUnmount()
    if self.steppedConnection then self.steppedConnection:disconnect() end
end

function Tooltip:render()
    local screenSize = self.props.screenSize
    local strings = self.props.strings
    local visible = self.props.visible
    local position = Vector2.new(
        math.max(math.min(self.state.position.X,screenSize.X - 192),0),
        math.max(math.min(self.state.position.Y,screenSize.Y - #strings*(24+2)),0)
    )

    local children = {}

    children.listLayout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0,2),
        FillDirection = Enum.FillDirection.Vertical,
    })

    for index,string in pairs(strings) do
        children[string.."_label"] = Roact.createElement("TextLabel",{
            Text = " "..string,
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,24),
            TextSize = 18,
            Font = index == 1 and Enum.Font.GothamBlack or Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = index,
        })
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,192,0,#strings*(24+2)),
        Position = UDim2.new(0,position.X,0,position.Y),

        BackgroundColor3 = Color3.new(1,1,1),
        BorderSizePixel = 0,

        Visible = visible,

        ZIndex = 5,
    },children)
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