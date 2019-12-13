local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local util = common.util
local invComponent = script.Parent
local component = script:FindFirstAncestor("component")

local Thunks = require(common.Thunks)
local Selectors = require(common.Selectors)
local Items = require(common.Items)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local ItemGrid = require(component.ItemGrid)
local SelectableItemButton = require(component.SelectableItemButton)
local ItemFocus = require(invComponent.ItemFocus)

local contains = require(util.contains)

local InventoryBody = Roact.PureComponent:extend("InventoryBody")

local function fitsTag(item, tagId)
    if not item then return false end

    local itemTags = item.tags or {}

    if contains(itemTags, tagId) then
        return true
    end

    if tagId == "all" then
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

    local searchFilter = self.props.searchFilter
    local tagFilter = self.props.tagFilter
    local selectedItem = self.props.selectedItem

    local setSelectedItem = function(itemId)
        local isEquipping = self.props.isEquipping
        if not isEquipping then
            self.props.setSelectedItem(itemId)
        end
    end

    local gridFrame = Roact.createElement(ItemGrid, {
        buttonKind = SelectableItemButton,
        items = inventory,
        ySize = 450,
        filters = {
            function(item) return fitsSearch(item, searchFilter) end,
            function(item) return fitsTag(item, tagFilter) end,
        },
        wrapAt = 5, -- in cells

        selectedId = selectedItem,
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
            itemGrid = gridFrame
        }),
        itemFocus = Roact.createElement(ItemFocus),
    })
end

local function mapStateToProps(state, props)
    return {
        inventory = Selectors.getInventory(state, LocalPlayer),
        isEquipping = Selectors.getIsEquipping(state),
    }
end

InventoryBody = RoactRodux.connect(mapStateToProps)(InventoryBody)

return InventoryBody