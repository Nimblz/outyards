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
local CELL_SIZE = ITEM_SIZE + (PADDING)

local ItemGrid = Roact.PureComponent:extend("ItemGrid")

local function filterItems(items,filters)
    local filteredItems = {}

    for id, quantity in pairs(items) do
        local item = Items.byId[id]

        if item then
            local failedFilter = false
            for _, filter in pairs(filters) do
                failedFilter = not filter(item)
                if failedFilter then break end
            end

            if not failedFilter then
                filteredItems[id] = quantity
            end
        end
    end

    return filteredItems
end

function ItemGrid:shouldUpdate(newProps, newState)
    -- should update if new items put thru the new filter do not match old items put thru old filter
    -- todo: should update if any prop other than filters changes
    debug.profilebegin("ItemGrid:shouldUpdate")

    local props = self.props
    local oldItems = props.items
    local newItems = newProps.items
    local oldFilters = props.filters
    local newFilters = newProps.filters
    local oldSelected = props.selectedId
    local newSelected = newProps.selectedId

    -- guarenteed that we need to update
    if oldSelected ~= newSelected then return true end
    if oldItems ~= newItems then return true end

    local oldFilteredItems = filterItems(oldItems, oldFilters)
    local newFilteredItems = filterItems(newItems, newFilters)

    -- check if filter results change
    for k,v in pairs(newFilteredItems) do
        if oldFilteredItems[k] ~= v then return true end
    end

    for k,v in pairs(oldFilteredItems) do
        if newFilteredItems[k] ~= v then return true end
    end

    debug.profileend()
    return false
end

function ItemGrid:render()
    local props = self.props
    local buttonKind = self.props.buttonKind or ItemButton
    local wrapAt = props.wrapAt or 5
    local items = props.items
    local filters = props.filters or {}
    local hideQuantity = props.hideQuantity or false
    local selectedId = props.selectedId
    local scrollbarPadding = props.scrollbarPadding or 12+8
    local ySize = props.ySize

    local onSelect = props.onSelect

    debug.profilebegin("ItemGrid:render()")

    -- create item buttons
    local filteredItems = filterItems(items, filters)
    local itemCount = 0
    local inventoryItems = {}
    for id, quantity in pairs(filteredItems) do
        if quantity > 0 then
            local item = Items.byId[id]

            if item then
                local itemSortOrder = item.sortOrder
                local newItemButton = Roact.createElement(buttonKind, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5,0,0.5,0),
                    LayoutOrder = itemSortOrder,

                    itemId = id,
                    quantity = quantity,
                    activatable = true,
                    selected = selectedId == id,
                    hideQuantity = hideQuantity,

                    onActivated = function(rbx, itemId) onSelect(itemId) end
                })

                inventoryItems[id] = newItemButton
                itemCount = itemCount + 1
            end
        end
    end

    -- create grid
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

    -- create scrolling frame
    local gridFrame = Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(0, (wrapAt * CELL_SIZE) + scrollbarPadding, 0, ySize),
        CanvasSize = UDim2.new(0,0,0,math.ceil(itemCount/wrapAt) * CELL_SIZE),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Selectable = false,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        TopImage = "rbxassetid://4360218963",
        MidImage = "rbxassetid://4271580709",
        BottomImage = "rbxassetid://4360219589",
        ClipsDescendants = false,
    }, {
        itemGrid = itemGrid
    })
    debug.profileend()

    return gridFrame
end

return ItemGrid