local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Items = require(common.Items)

local ItemButton = require(component.ItemButton)
local FitGrid = require(component.FitGrid)

local ITEM_SIZE = 64
local PADDING = 16
local CELL_SIZE = ITEM_SIZE + (PADDING/2)

return function(props)
    local wrapAt = props.wrapAt or 5
    local items = props.items
    local filters = props.filters or {}


    local itemCount = 0
    local inventoryItems = {}
    for id, quantity in pairs(items) do
        if quantity > 0 then
            local item = Items.byId[id]

            local failedFilter = false
            for _,filter in pairs(filters) do
                if not filter(item) then
                    failedFilter = true
                    break
                end
            end

            if item and not failedFilter then
                local itemSortOrder = item.sortOrder
                local newItemButton = Roact.createElement(ItemButton, {
                    itemId = id,
                    quantity = quantity,
                    activatable = true,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5,0,0.5,0),
                })

                local itemFrame = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0,ITEM_SIZE,0,ITEM_SIZE),
                    LayoutOrder = itemSortOrder,
                }, {item = newItemButton})

                inventoryItems[id] = itemFrame
                itemCount = itemCount + 1
            end
        end
    end

    local itemGrid = Roact.createElement(FitGrid, {
        layoutProps = {
            CellPadding = UDim2.new(0,0,0,0),
            CellSize = UDim2.new(0,CELL_SIZE,0,CELL_SIZE),
            FillDirectionMaxCells = wrapAt,
            SortOrder = Enum.SortOrder.LayoutOrder,
        },
        paddingProps = {
        },
        containerProps = {
            Size = UDim2.new(0,CELL_SIZE*wrapAt,0,0),
            BackgroundTransparency = 1,
        }
    }, inventoryItems)

    local gridFrame = Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0),
        CanvasSize = UDim2.new(0,0,0,math.ceil(itemCount/wrapAt) * CELL_SIZE),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Selectable = false,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        TopImage = "rbxassetid://4271581206",
        MidImage = "rbxassetid://4271580709",
        BottomImage = "rbxassetid://4271581830",
        ClipsDescendants = false,
    }, {
        itemGrid = itemGrid
    })

    return gridFrame
end