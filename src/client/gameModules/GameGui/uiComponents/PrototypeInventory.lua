local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Selectors = require(common:WaitForChild("Selectors"))

local Items = require(common:WaitForChild("Items"))

local ItemLabel = require(uiComponents:WaitForChild("ItemLabel"))

local PrototypeInventory = Roact.Component:extend("PrototypeInventory")

local PADDING = 8

function PrototypeInventory:init()
end

function PrototypeInventory:didMount()
end

function PrototypeInventory:render()

    local inventory = self.props.inventory

    local children = {
        listLayout = Roact.createElement("UIGridLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            CellSize = UDim2.new(0,48,0,48),
            CellPadding = UDim2.new(0,8,0,8),
        }),
        margin = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0,4),
            PaddingTop = UDim.new(0,4),
            PaddingLeft = UDim.new(0,4),
            PaddingRight = UDim.new(0,4),
        }),
    }

    for id, quantity in pairs(inventory) do
        if quantity > 0 then
            local item = Items.byId[id]
            local itemSortOrder = item.sortOrder
            local newItemLabel = Roact.createElement(ItemLabel, {
                itemId = id,
                quantity = quantity,
                activatable = true,
                layoutOrder = itemSortOrder
            })

            children[id] = newItemLabel
        end
    end

    local titleFrame = Roact.createElement("TextLabel", {
        Text = "Inventory",
        Font = Enum.Font.GothamBlack,
        Size = UDim2.new(1,0,0,32),
        AnchorPoint = Vector2.new(0,1),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1,1,1),
        TextStrokeTransparency = 0,
        TextSize = 32,
    })

    local scrollFrame = Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0),

        BorderSizePixel = 0,
        BackgroundTransparency = 0.75,
        BackgroundColor3 = Color3.new(1,1,1),
        Selectable = false,

        ScrollBarThickness = 16,
        TopImage = "rbxassetid://1539341292",
        MidImage = "rbxassetid://1539341292",
        BottomImage = "rbxassetid://1539341292",
        CanvasSize = UDim2.new(0,0,1,0),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    }, children)

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,(48+8)*6 + 16,0,600),
        AnchorPoint = Vector2.new(1,0.5),
        Position = UDim2.new(1,0,0.5,0),

        BorderSizePixel = 0,
        BackgroundTransparency = 1,
    }, {
        scrollFrame = scrollFrame,
        titleFrame = titleFrame,
    })
end

local function mapStateToProps(state,props)
    return {
        inventory = Selectors.getInventory(state,LocalPlayer)
    }
end

PrototypeInventory = RoactRodux.connect(mapStateToProps)(PrototypeInventory)

return PrototypeInventory