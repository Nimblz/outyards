local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local components = script:FindFirstAncestor("uiComponents")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundFrame = require(components:WaitForChild("RoundFrame"))
local FitList = require(components:WaitForChild("FitList"))
local Inventory = Roact.Component:extend("Inventory")

function Inventory:init()
end

function Inventory:didMount()
end

function Inventory:render()
    local visible = self.props.visible

    return Roact.createElement(FitList, {
        containerKind = RoundFrame,
        layoutProps = {
            Padding = UDim.new(0,16)
        },
        paddingProps = {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,16),
            PaddingRight = UDim.new(0,16),
        },
        containerProps = {
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            ZIndex = 2,

            Visible = visible
        }
    }, {
        title = Roact.createElement("TextLabel", {
            Text = "Inventory",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,0,32),
            TextSize = 32,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,

            LayoutOrder = 1,
        }),
        body = Roact.createElement(FitList, {
            containerProps = {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
            },
            layoutProps = {
                Padding = UDim.new(0,16),
                FillDirection = Enum.FillDirection.Horizontal,
            }
        }, {
            itemsView = Roact.createElement(RoundFrame, {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,450,0,450)
            }),
            itemFocus = Roact.createElement(RoundFrame, {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,250,1,0)
            }),
        })
    })
end

local function mapStateToProps(state,props)
    return {
        visible = Selectors.getInventoryVisible(state)
    }
end

Inventory = RoactRodux.connect(mapStateToProps)(Inventory)

return Inventory