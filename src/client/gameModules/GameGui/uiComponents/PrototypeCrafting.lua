local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local crafting = common:WaitForChild("crafting")
local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))

local CraftableLabel = require(uiComponents:WaitForChild("CraftableLabel"))
local PrototypeCrafting = Roact.Component:extend("PrototypeCrafting")

local getCraftable = require(crafting:WaitForChild("getCraftable"))
local canCraft = require(crafting:WaitForChild("canCraft"))
local getItemsWithIngredientOwned = require(crafting:WaitForChild("getItemsWithIngredientOwned"))

local PADDING = 8

function PrototypeCrafting:init()
end

function PrototypeCrafting:didMount()
end

function PrototypeCrafting:render()

    local ingredientsOwned = self.props.ingredientsOwned

    local children = {
        listLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,PADDING),
            FillDirection = Enum.FillDirection.Vertical,
        }),
    }

    for id, _ in pairs(ingredientsOwned) do
        local item = Items.byId[id]
        local itemSortOrder = item.sortOrder
        local newCraftableLabel = Roact.createElement(CraftableLabel, {
            itemId = id,
            isCraftable = canCraft(self.props.state, LocalPlayer, id),
            layoutOrder = itemSortOrder
        })

        children[id] = newCraftableLabel
    end

    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(0,400,0,600),
        AnchorPoint = Vector2.new(0,0.5),
        Position = UDim2.new(0,0,0.5,0),

        BorderSizePixel = 0,
        BackgroundTransparency = 0.75,
        BackgroundColor3 = Color3.new(1,1,1),

        ScrollBarThickness = 16,
        TopImage = "rbxassetid://1539341292",
        MidImage = "rbxassetid://1539341292",
        BottomImage = "rbxassetid://1539341292",
        CanvasSize = UDim2.new(0,0,2,0),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    }, children)
end

local function mapStateToProps(state,props)
    return {
        ingredientsOwned = getItemsWithIngredientOwned(state,LocalPlayer),
        state = state,
    }
end

PrototypeCrafting = RoactRodux.connect(mapStateToProps)(PrototypeCrafting)

return PrototypeCrafting