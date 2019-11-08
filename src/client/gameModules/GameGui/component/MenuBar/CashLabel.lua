local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("component")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitText = require(component:WaitForChild("FitText"))
local CashLabel = Roact.Component:extend("CashLabel")

local beautifyNumber = require(util:WaitForChild("beautifyNumber"))

local HORIZONTAL_SIZE = 200
local VERTICAL_SIZE = 72
local PADDING = 16

function CashLabel:init()
end

function CashLabel:didMount()
end

function CashLabel:render()

    local cashValue = self.props.cashValue or 0

    local children = {
        icon = Roact.createElement("ImageLabel", {
            Image = "rbxassetid://3977083793",
            Size = UDim2.new(0,48,0,48),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
        }),
        coinText = Roact.createElement(FitText, {
            Text = (cashValue and "$"..beautifyNumber(cashValue)) or "N/A",
            Size = UDim2.new(0,0,1,0),
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1,1,1),
            TextStrokeTransparency = 0.5,
            LayoutOrder = 2,
            TextSize = 32,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBlack,
        })
    }

    return Roact.createElement(FitList, {
        containerKind = RoundFrame,
        containerProps = {
            Size = UDim2.new(0,HORIZONTAL_SIZE,0,VERTICAL_SIZE),
            Position = UDim2.new(0,PADDING,1,-PADDING),
            AnchorPoint = Vector2.new(0,1),
            LayoutOrder = 1,
        },
        fitAxes = "X",
        minSize = Vector2.new(HORIZONTAL_SIZE,0),
        layoutProps = {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,PADDING),
            FillDirection = Enum.FillDirection.Horizontal,
        },
        paddingProps = {
            PaddingTop = UDim.new(0,12),
            PaddingBottom = UDim.new(0,12),
            PaddingLeft = UDim.new(0,12),
            PaddingRight = UDim.new(0,12),
        }
    }, children)
end

local function mapStateToProps(state,props)
    local cash = Selectors.getCash(state,LocalPlayer)
    return {
        cashValue = cash
    }
end

CashLabel = RoactRodux.connect(mapStateToProps)(CashLabel)

return CashLabel