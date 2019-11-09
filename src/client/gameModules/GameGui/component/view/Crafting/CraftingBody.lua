local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("component")
local craftingComponent = script.Parent

local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitGrid = require(component:WaitForChild("FitGrid"))

local contains = require(util:WaitForChild("contains"))

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
            LayoutOrder = 1,
        }),
        recipeFocus = Roact.createElement(RoundFrame, {
            color = Color3.fromRGB(216, 216, 216),
            Size = UDim2.new(0,250,0,450),
            ClipsDescendants = true,
            LayoutOrder = 2,
        })
    })
end

local function mapStateToProps(state, props)
    return {
        inventory = Selectors.getInventory(state, LocalPlayer),
        isEquipped = function(itemId)
            return Selectors.getIsEquipped(state, LocalPlayer, itemId)
        end,
    }
end

CraftingBody = RoactRodux.connect(mapStateToProps)(CraftingBody)

return CraftingBody