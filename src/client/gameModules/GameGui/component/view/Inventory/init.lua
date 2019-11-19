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
        selectedItem = nil,

        setSelected = function(itemId)
            self:setSelected(itemId)
        end
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
    local alreadySelected = self.state.selectedItem == itemId
    self:setState({
        selectedItem = (owned and not alreadySelected and itemId) or Roact.None
    })
end

function Inventory:render()

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
            selectedItem = self.state.selectedItem,
            setSelectedItem = self.state.setSelected,
        })
    }

    local children = Dictionary.join(viewContent, self.props[Roact.Children])

    return Roact.createElement(FitList, {
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
        end
    }
end

Inventory = RoactRodux.connect(mapStateToProps)(Inventory)

Inventory = makeView(Inventory, "inventory")

return Inventory