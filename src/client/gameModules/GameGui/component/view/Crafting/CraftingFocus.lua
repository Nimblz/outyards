local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local event = ReplicatedStorage.event
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Items = require(common.Items)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local ItemInfo = require(component.ItemInfo)
local RoundFrame = require(component.RoundFrame)
local FancyButton = require(component.FancyButton)
local FitList = require(component.FitList)
local SpriteDisplay = require(component.SpriteDisplay)

local CraftingFocus = Roact.PureComponent:extend("CraftingFocus")

local eRequestCraft = event.eRequestCraft

function craftItem(id)
    eRequestCraft:FireServer(id)
end

function CraftingFocus:render()
    local selectedItemId = self.props.selectedItemId
    local canCraft = self.props.canCraft
    local item = Items.byId[selectedItemId]

    print(canCraft, selectedItemId)

    local children = {}

    if canCraft then
        -- show item name, stats, recipe, and crafting button
        children.infoFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1,0,0,0),
            BackgroundTransparency = 1
        })

        children.buttonFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1,0,0,0),
            AnchorPoint = Vector2.new(0,1),
            Position = UDim2.new(0,0,1,0),
            BackgroundTransparency = 1
        }, {
            craftingButton = Roact.createElement(FancyButton, {
                AnchorPoint = Vector2.new(0,1),
                color = Color3.new(0, 1, 0),
                Size = UDim2.new(1, 0, 0, 64),

                [Roact.Event.Activated] = function() craftItem(selectedItemId) end
            }, {
                textLabel = Roact.createElement("TextLabel", {
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    Text = "Craft!",
                    Font = Enum.Font.GothamBlack,
                    TextSize = 32,
                })
            })
        })
    else
        children.text = Roact.createElement("TextLabel", {
            Text = "Select an item to craft!",
            Font = Enum.Font.GothamBlack,
            TextSize = 32,
            TextWrapped = true,
            Size = UDim2.new(1,0,1,0),
            TextColor3 = Color3.fromRGB(128, 128, 128),
            BackgroundTransparency = 1,
        })
    end

    children.padding = Roact.createElement("UIPadding",{
        PaddingTop = UDim.new(0,16),
        PaddingBottom = UDim.new(0,16),
        PaddingLeft = UDim.new(0,16),
        PaddingRight = UDim.new(0,16),
    })

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,250,1,0),
        LayoutOrder = 2,
        BackgroundTransparency = 1,
    }, children)
end

local function mapStateToProps(state, props)
    local selectedItemId = Selectors.getSelectedItem(state)

    return {
        selectedItemId = selectedItemId,
        canCraft = Selectors.canCraft(state, LocalPlayer, selectedItemId),
    }
end

CraftingFocus = RoactRodux.connect(mapStateToProps)(CraftingFocus)

return CraftingFocus