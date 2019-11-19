local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")
local util = common.util

local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local withScale = require(component.withScale)
local ToolbarButton = require(script.ToolbarButton)

local Toolbar = Roact.Component:extend("Toolbar")

local FrameWithScale = withScale("Frame", {
    defaultSize = Vector2.new(1280,600),
    scale = 1,
    minScale = 0.5,
    maxScale = 1,
    scaleIncrement = 0.25,
})

function Toolbar:init()
end

function Toolbar:render()

    local mainButtons = {}
    local abilityButtons = {}

    for index = 1, 4 do
        mainButtons["weapon_"..index] = Roact.createElement(ToolbarButton, {
            index = index,
        })
    end

    abilityButtons.trinketAbility = Roact.createElement(ToolbarButton, {
        index = 1,
    })

    abilityButtons.weaponAbility = Roact.createElement(ToolbarButton, {
        index = 2,
    })

    local function makeToolbar(children)
        return Roact.createElement(FitList, {
            containerKind = RoundFrame,
            paddingProps = {
                PaddingTop = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
            },
            layoutProps = {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0,16),
            },
            containerProps = {
                LayoutOrder = 1,
            },
        }, children)
    end

    return Roact.createElement(FrameWithScale,{
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5,1),
        AnchorPoint = Vector2.new(0.5,1),
        BackgroundTransparency = 1,
    }, {
        padding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,16),
            PaddingRight = UDim.new(0,16),
        }),
        layout = Roact.createElement("UIListLayout",{
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0,16),
        }),
        mainbar = makeToolbar(mainButtons),
        abilitybar = makeToolbar(abilityButtons),
    })
end

local function mapStateToProps(state, props)
    return {
        visible = Selectors.getToolbarVisible(state),
    }
end

Toolbar = RoactRodux.connect(mapStateToProps)(Toolbar)

return Toolbar