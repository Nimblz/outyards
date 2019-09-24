local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local uiComponents = script.Parent

local eRequestCraft = event:WaitForChild("eRequestCraft")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))

local Items = require(common:WaitForChild("Items"))

local ItemLabel = require(uiComponents:WaitForChild("ItemLabel"))
local CraftableLabel = Roact.Component:extend("CraftableLabel")

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
            Padding = UDim.new(0,2),
            FillDirection = Enum.FillDirection.Vertical,
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
            layoutOrder = ingredientItem.tier
        })
    end

    local children = {
        listLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,16),
            FillDirection = Enum.FillDirection.Vertical,
        }),
        margin = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0,4),
            PaddingTop = UDim.new(0,4),
            PaddingLeft = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
        }),
        craftableItem = Roact.createElement(ItemLabel, {
            itemId = itemId,
            quantity = isCraftable and "CRAFTABLE" or "UNCRAFTABLE",
            layoutOrder = 1,
        }),
        ingredientList = Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(1,0,1,-55),
            LayoutOrder = 2,

            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(0.8,0.8,0.8),

            ScrollBarThickness = 8,
            TopImage = "rbxassetid://1539341292",
            MidImage = "rbxassetid://1539341292",
            BottomImage = "rbxassetid://1539341292",
            CanvasSize = UDim2.new(0,0,0,0),
            VerticalScrollBarInset = Enum.ScrollBarInset.Always,
        }, ingredientElements)
    }

    return Roact.createElement("ImageButton", {
        Size = UDim2.new(1,0,2/3,0),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        BorderSizePixel = 0,
        BackgroundColor3 = isCraftable and Color3.new(0.9,0.9,0.9) or Color3.new(0.7,0.7,0.7),
        LayoutOrder = layoutOrder,
        Image = "",
        [Roact.Event.MouseButton1Click] = function()
            eRequestCraft:FireServer(itemId)
        end
    }, children)
end

local function mapStateToProps(state,props)
    return {
        state = state
    }
end

CraftableLabel = RoactRodux.connect(mapStateToProps)(CraftableLabel)

return CraftableLabel