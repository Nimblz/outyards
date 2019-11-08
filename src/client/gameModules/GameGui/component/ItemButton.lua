local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("component")

local Roact = require(lib:WaitForChild("Roact"))

local SpriteLabel = require(component:WaitForChild("SpriteLabel"))
local RoundButton = require(component:WaitForChild("RoundButton"))

local ItemButton = Roact.Component:extend("ItemButton")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

function ItemButton:render()
    local itemId = self.props.itemId
    local layoutOrder = self.props.layoutOrder
    local isHidden = self.props.isHidden
    local scale = self.props.scale or 4

    local item = Items.byId[itemId]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local sprite = Roact.createElement(SpriteLabel, {
        itemId = itemId,
        layoutOrder = layoutOrder,
        color = isHidden and Color3.new(0.2, 0.2, 0.2),
        scale = scale,
    })

    return Roact.createElement(RoundButton, {
        Size = UDim2.fromOffset(24 * scale, 24 * scale)
    })
end

return ItemButton