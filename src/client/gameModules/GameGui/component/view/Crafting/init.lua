local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local util = common.util
local component = script:FindFirstAncestor("component")

local eRequestEquip = event.eRequestEquip

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local RoundFrame = require(component.RoundFrame)
local FitList = require(component.FitList)
local CraftingBody = require(script.CraftingBody)
local CraftingNavbar = require(script.CraftingNavbar)

local makeView = require(script.Parent.makeView)

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
    local viewVisible = self.props.visible

    local function setSelected(id)
        if self.props.selectedItem == id then
            self.props.setSelected(nil)
        else
            self.props.setSelected(id)
        end
    end

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
            setSelectedItem = setSelected,
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

Crafting = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Crafting)

Crafting = makeView(Crafting, "crafting")

return Crafting