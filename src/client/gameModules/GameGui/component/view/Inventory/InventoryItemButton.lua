local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Dictionary = require(util.Dictionary)

local ItemButton = require(component.ItemButton)

return function(props)
    local itemButton = Roact.createElement(ItemButton, props)

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1
    }, {
        button = itemButton
    })
end