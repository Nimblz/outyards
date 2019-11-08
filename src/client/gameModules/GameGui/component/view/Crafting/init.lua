local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("component")

local eRequestEquip = event:WaitForChild("eRequestEquip")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local CraftingBody = require(script:WaitForChild("CraftingBody"))
local CraftingNavbar = require(script:WaitForChild("CraftingNavbar"))

local makeView = require(script.Parent:WaitForChild("makeView"))

local Crafting = Roact.PureComponent:extend("Crafting")

function Crafting:init()
    self:setState({
        tagFilter = "all",
        searchFilter = "",
    })
end

function Crafting:setTagFilter(newTag)
    self:setState({
        tagFilter = newTag,
    })
end

function Crafting:setSearchFilter(newSearch)
    self:setState({
        searchFilter = newSearch,
    })
end

function Crafting:render()

    local viewContent = {
        title = Roact.createElement("TextLabel", {
            Text = "Crafting",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,0,32),
            TextSize = 32,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,

            LayoutOrder = 1,
        }),
        navbar = Roact.createElement(CraftingNavbar, {
            searchUpdate = function(newText) self:setSearchFilter(newText) end,
            tagUpdate = function(newTag) self:setTagFilter(newTag) end,
        }),
        body = Roact.createElement(CraftingBody, {
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

Crafting = makeView(Crafting, "crafting")

return Crafting