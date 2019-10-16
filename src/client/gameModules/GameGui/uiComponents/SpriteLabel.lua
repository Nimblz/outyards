local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))
local Items = require(common:WaitForChild("Items"))
local Sprites = require(common:WaitForChild("Sprites"))

local SpriteLabel = Roact.Component:extend("SpriteLabel")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

function SpriteLabel:init()
end

function SpriteLabel:didMount()
end

function SpriteLabel:render()

    local itemId = self.props.itemId
    local color = self.props.color
    local layoutOrder = self.props.layoutOrder

    local item = Items.byId[itemId]
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteRectSize = spriteSheet.spriteSize * spriteSheet.scaleFactor
    local spriteRectOffset = Vector2.new(
        (item.spriteCoords.X-1) * spriteSheet.spriteSize.X,
        (item.spriteCoords.Y-1) * spriteSheet.spriteSize.Y
    )   * spriteSheet.scaleFactor

    local elementProps = {
        Size = UDim2.new(0,spriteSheet.spriteSize.X * 3,0,spriteSheet.spriteSize.Y * 3),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),

        Image = spriteSheet.assetId,
        ImageRectSize = spriteRectSize,
        ImageRectOffset = spriteRectOffset,

        LayoutOrder = layoutOrder,

        ImageColor3 = color or Color3.new(1,1,1),
    }

    return Roact.createElement("ImageLabel", elementProps)
end

return SpriteLabel