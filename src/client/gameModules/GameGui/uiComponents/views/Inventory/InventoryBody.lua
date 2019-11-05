local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local invComponent = script.Parent
local component = script:FindFirstAncestor("uiComponents")

local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitGrid = require(component:WaitForChild("FitGrid"))
local ItemLabel = require(component:WaitForChild("ItemLabel"))

local contains = require(util:WaitForChild("contains"))

local InventoryBody = Roact.PureComponent:extend("InventoryBody")

local function fitsTag(item, tagId, isEquipped)
    if not item then return false end

    local tagFilter = tagId

    local itemTags = item.tags or {}

    if contains(itemTags, tagFilter) then
        return true
    end

    if tagFilter == "equipped" then
        return isEquipped
    end

    if tagFilter == "all" then
        return true
    end

    return false
end

local function fitsSearch(item, searchString)
    if not item then return false end

    local searchFilter = searchString:lower()
    local lowercaseName = item.name:lower()

    if searchFilter == "" then return true end

    if lowercaseName:match(searchFilter) then return true end

    return false
end

function InventoryBody:render()
    local inventory = self.props.inventory

    local itemCount = 0
    local inventoryItems = {}
    for id, quantity in pairs(inventory) do
        if quantity > 0 then
            local item = Items.byId[id]
            local isEquipped = self.props.isEquipped(id)
            local searchFilter = self.props.searchFilter
            local tagFilter = self.props.tagFilter
            local itemFitsSearch = fitsSearch(item, searchFilter)
            local itemFitsTag = fitsTag(item, tagFilter, isEquipped)
            if item and itemFitsTag and itemFitsSearch then
                local itemSortOrder = item.sortOrder
                local newItemLabel = Roact.createElement(ItemLabel, {
                    itemId = id,
                    quantity = quantity,
                    activatable = true,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5,0,0.5,0),
                })

                local itemFrame = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0,64,0,64),
                    LayoutOrder = itemSortOrder,
                }, {item = newItemLabel})

                inventoryItems[id] = itemFrame
                itemCount = itemCount + 1
            end
        end
    end

    local itemGrid = Roact.createElement(FitGrid, {
        layoutProps = {
            CellPadding = UDim2.new(0,0,0,0),
            CellSize = UDim2.new(0,80,0,80),
            FillDirectionMaxCells = 5,
            SortOrder = Enum.SortOrder.LayoutOrder,
        },
        paddingProps = {
        },
        containerProps = {
            Size = UDim2.new(0,80*5,0,0),
            BackgroundTransparency = 1,
        }
    }, inventoryItems)

    return Roact.createElement(FitList, {
        scale = 1,
        containerProps = {
            BackgroundTransparency = 1,
            LayoutOrder = 3,
        },
        layoutProps = {
            Padding = UDim.new(0,16),
            FillDirection = Enum.FillDirection.Horizontal,
        }
    }, {
        itemsView = Roact.createElement(RoundFrame, {
            color = Color3.fromRGB(216, 216, 216),
            Size = UDim2.new(0,450,0,450),
            ClipsDescendants = true,
        }, {
            padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,12),
            }),
            gridFrame = Roact.createElement("ScrollingFrame", {
                Size = UDim2.new(1,0,1,0),
                CanvasSize = UDim2.new(0,0,0,math.ceil(itemCount/5) * 80),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Selectable = false,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                TopImage = "rbxassetid://4271581206",
                MidImage = "rbxassetid://4271580709",
                BottomImage = "rbxassetid://4271581830",
                ClipsDescendants = false,
            }, itemGrid)
        }),
        itemFocus = Roact.createElement(RoundFrame, {
            color = Color3.fromRGB(216, 216, 216),
            Size = UDim2.new(0,250,0,450)
        }),
    })
end

local function mapStateToProps(state,props)
    return {
        inventory = Selectors.getInventory(state, LocalPlayer),
        isEquipped = function(itemId)
            return Selectors.getIsEquipped(state, LocalPlayer, itemId)
        end,
    }
end

InventoryBody = RoactRodux.connect(mapStateToProps)(InventoryBody)

return InventoryBody