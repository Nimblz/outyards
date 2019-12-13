local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")
local view = script.Parent

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local InventoryNavbar = require(script.InventoryNavbar)
local InventoryBody = require(script.InventoryBody)

local makeView = require(view.makeView)

local Inventory = Roact.PureComponent:extend("Inventory")

function Inventory:init()
    self:setState({
        tagFilter = "all",
        searchFilter = "",
    })
end

function Inventory:setTagFilter(newTag)
    self:setState({
        tagFilter = newTag,
    })
end

function Inventory:setSearchFilter(newSearch)
    self:setState({
        searchFilter = newSearch,
    })
end

function Inventory:setSelected(itemId)
    local owned = self.props.isOwned(itemId)
    local alreadySelected = self.props.selectedItem == itemId
    local newSelectedItem = (owned and not alreadySelected and itemId) or Roact.None

    self.props.setSelected(newSelectedItem)
end

function Inventory:render()
    local viewVisible = self.props.visible

    local viewContent = {
        title = Roact.createElement("TextLabel", {
            Text = "Inventory",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,0,32),
            TextSize = 32,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,

            LayoutOrder = 1,
        }),
        navbar = Roact.createElement(InventoryNavbar, {
            searchUpdate = function(newText) self:setSearchFilter(newText) end,
            tagUpdate = function(newTag) self:setTagFilter(newTag) end,
        }),
        body = Roact.createElement(InventoryBody, {
            searchFilter = self.state.searchFilter,
            tagFilter = self.state.tagFilter,
            selectedItem = self.props.selectedItem,
            setSelectedItem = function(itemId)
                self:setSelected(itemId)
            end,
        })
    }

    local children = Dictionary.join(viewContent, self.props[Roact.Children])

    return viewVisible and Roact.createElement(FitList, {
        containerKind = RoundFrame,
        scale = 1,
        layoutProps = {
            Padding = UDim.new(0,16)
        },
        paddingProps = {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,16),
            PaddingRight = UDim.new(0,16),
        },
        containerProps = {
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            ZIndex = 2,
            Active = true,
        }
    }, children)
end

local function mapStateToProps(state, props)
    return {
        isOwned = function(itemId)
            return Selectors.getItem(state, LocalPlayer, itemId)
        end,
        selectedItem = Selectors.getSelectedItem(state),
    }
end

local function mapDispatchToProps(dispatch)
    return {
        setSelected = function(itemId)
            dispatch(Actions.SELECTEDITEM_SET(itemId))
        end
    }
end

Inventory = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Inventory)

Inventory = makeView(Inventory, "inventory")

return Inventory