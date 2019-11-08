local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local util = common.util
local component = script:FindFirstAncestor("component")
local view = script.Parent

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local InventoryNavbar = require(script.InventoryNavbar)
local InventoryBody = require(script.InventoryBody)

local makeView = require(view.makeView)

local eRequestEquip = event.eRequestEquip
local eRequestUnequip = event.eRequestUnequip

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

Inventory = makeView(Inventory, "inventory")

return Inventory