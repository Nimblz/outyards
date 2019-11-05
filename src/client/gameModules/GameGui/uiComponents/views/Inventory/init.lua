local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("uiComponents")

local eRequestEquip = event:WaitForChild("eRequestEquip")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local InventoryNavbar = require(script:WaitForChild("InventoryNavbar"))
local InventoryBody = require(script:WaitForChild("InventoryBody"))

local makeView = require(script.Parent:WaitForChild("makeView"))

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