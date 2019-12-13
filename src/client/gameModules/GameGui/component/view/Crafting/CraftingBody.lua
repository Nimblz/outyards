local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local util = common.util
local component = script:FindFirstAncestor("component")
local craftingComponent = script.Parent

local Selectors = require(common.Selectors)
local Items = require(common.Items)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local CraftingFocus = require(craftingComponent.CraftingFocus)
local SelectableItemButton = require(component.SelectableItemButton)
local ItemGrid = require(component.ItemGrid)

local contains = require(util.contains)

local CraftingBody = Roact.PureComponent:extend("CraftingBody")

local function fitsTag(item, tagId)
    if not item then return false end

    local tagFilter = tagId

    local itemTags = item.tags or {}

    if contains(itemTags, tagFilter) then
        return true
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

function CraftingBody:render()
    local searchFilter = self.props.searchFilter
    local tagFilter = self.props.tagFilter
    local rawCraftableItems = self.props.craftableItems
    local craftableItems = {}

    for id, _ in pairs(rawCraftableItems) do
        craftableItems[id] = 1
    end

    local setSelectedItem = function(itemId)
        local isEquipping = self.props.isEquipping
        if not isEquipping then
            self.props.setSelectedItem(itemId)
        end
    end

    local itemGrid = Roact.createElement(ItemGrid, {
        buttonKind = SelectableItemButton,
        items = craftableItems,
        hideQuantity = true,
        ySize = 450,
        filters = {
            function(item) return fitsSearch(item, searchFilter) end,
            function(item) return fitsTag(item, tagFilter) end,
        },
        wrapAt = 5, -- in cells

        selectedId = self.props.selectedItemId,
        onSelect = setSelectedItem,
    })

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
        itemsView = Roact.createElement(FitList, {
            containerKind = RoundFrame,
            paddingProps = {
                PaddingTop = UDim.new(0,8),
                PaddingBottom = UDim.new(0,8),
                PaddingLeft = UDim.new(0,8),
                PaddingRight = UDim.new(0,12),
            },
            containerProps = {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,450,0,450),
                ClipsDescendants = true,
                LayoutOrder = 1,
            }
        }, {
            itemGrid = itemGrid
        }),
        recipeFocus = Roact.createElement(CraftingFocus, {
        }) -- todo: recipe focus
    })
end

local function mapStateToProps(state, props)
    local selectedItemId = Selectors.getSelectedItem(state)
    return {
        selectedItemId = selectedItemId,
        craftableItems = Selectors.getCraftable(state, LocalPlayer),
    }
end

CraftingBody = RoactRodux.connect(mapStateToProps)(CraftingBody)

return CraftingBody