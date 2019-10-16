local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local uiComponents = script.Parent.Parent
local legacy = uiComponents:WaitForChild("legacy")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))
local Items = require(common:WaitForChild("Items"))

local ItemLabel = require(uiComponents:WaitForChild("ItemLabel"))
local CraftableLabel = Roact.Component:extend("CraftableLabel")

local eRequestCraft = event:WaitForChild("eRequestCraft")
local eRequestEquip = event:WaitForChild("eRequestEquip")

local errors = {
    invalidItemId = "Invalid itemId [%s]!"
}

function CraftableLabel:init()
end

function CraftableLabel:didMount()
end

function CraftableLabel:render()
    local itemId = self.props.itemId
    local isCraftable = self.props.isCraftable
    local layoutOrder = self.props.layoutOrder or 0

    local item = Items.byId[itemId]

    assert(item, errors.invalidItemId:format(tostring(itemId)))

    local ingredientElements = {
        listLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,8),
            FillDirection = Enum.FillDirection.Horizontal,
        }),
        margin = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0,4),
            PaddingTop = UDim.new(0,4),
            PaddingLeft = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
        })
    }

    for id,quantity in pairs(item.recipe) do
        local ingredientItem = Items.byId[id]
        ingredientElements[id] = Roact.createElement(ItemLabel, {
            itemId = id,
            quantity = quantity,
            isGray = Selectors.getItem(self.props.state, LocalPlayer, id) < quantity,
            layoutOrder = ingredientItem.sortOrder
        })
    end

    local children = {
        listLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,4),
            FillDirection = Enum.FillDirection.Horizontal,
        }),
        margin = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0,4),
            PaddingTop = UDim.new(0,4),
            PaddingLeft = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
        }),
        craftableItem = Roact.createElement(ItemLabel, {
            itemId = itemId,
            isGray = not isCraftable,
            layoutOrder = 1,
            quantity = item.craftQuantity
        }),
        arrowLabel = Roact.createElement(ItemLabel, {
            itemId = "leftNavArrow",
            layoutOrder = 2,
            showTooltip = false,
        }),
        ingredientList = Roact.createElement("Frame", {
            Size = UDim2.new(1,-128,1,0),
            LayoutOrder = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(0.8,0.8,0.8),
        }, ingredientElements)
    }

    return Roact.createElement("ImageButton", {
        Size = UDim2.new(1,0,0,74),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        BorderSizePixel = 0,
        BackgroundColor3 = isCraftable and Color3.new(0.9,0.9,0.9) or Color3.new(0.7,0.7,0.7),
        LayoutOrder = layoutOrder,
        Image = "",
        [Roact.Event.MouseButton1Click] = function()
            eRequestCraft:FireServer(itemId)
            eRequestEquip:FireServer(itemId)
            self.props.hideTooltip()
        end
    }, children)
end

local function mapStateToProps(state,props)
    return {
        state = state
    }
end

local function mapDispatchToProps(dispatch)
    return {
        hideTooltip = function()
            dispatch(Actions.TOOLTIP_VISIBLE_SET(false))
        end
    }
end

CraftableLabel = RoactRodux.connect(mapStateToProps,mapDispatchToProps)(CraftableLabel)

return CraftableLabel