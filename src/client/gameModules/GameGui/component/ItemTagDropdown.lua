local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)
local ItemTags = require(common.ItemTags)

local DropdownMenu = require(component.DropdownMenu)
local ItemTagDropdown = Roact.Component:extend("ItemTagDropdown")

local function noop()
end

function ItemTagDropdown:init()
end

function ItemTagDropdown:didMount()
end

function ItemTagDropdown:render()

    local onSelect = self.props.onSelect or noop
    local options = {}
    local tagMap = {}

    for index, tag in pairs(ItemTags.all) do
        tagMap[index] = tag
        table.insert(options, (tag.prefix or "❓").." "..tag.name)
    end

    local mergedProps = Dictionary.join(self.props, {
        options = options,
        onSelect = function(newIndex)
            local tag = tagMap[newIndex]
            onSelect(tag)
        end,
    })

    return Roact.createElement(DropdownMenu, mergedProps)
end

return ItemTagDropdown