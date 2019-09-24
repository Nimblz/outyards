local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local Items = require(common:WaitForChild("Items"))
local Sprites = require(common:WaitForChild("Sprites"))

local ItemLabel = Roact.Component:extend("ItemLabel")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

function ItemLabel:init()
end

function ItemLabel:didMount()
end

function ItemLabel:render()
    local itemId = self.props.itemId
    local quantity = self.props.quantity
    local isGray = self.props.isGray
    local layoutOrder = self.props.layoutOrder or 0


    local item = Items.byId[itemId]
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteRectSize = spriteSheet.spriteSize * spriteSheet.scaleFactor
    local spriteRectOffset = Vector2.new(
        (item.spriteCoords.X-1) * spriteSheet.spriteSize.X,
        (item.spriteCoords.Y-1) * spriteSheet.spriteSize.Y
    )   * spriteSheet.scaleFactor


    local quantityLabel
    if quantity then
        quantityLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(0,24,0,24),
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text = quantity,
            TextSize = 24,
            TextColor3 = Color3.new(1,1,1),
            TextStrokeTransparency = 0,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextYAlignment = Enum.TextYAlignment.Bottom,
        })
    end

    return Roact.createElement("ImageLabel", {
        Size = UDim2.new(0,48,0,48),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,

        Image = spriteSheet.assetId,
        ImageRectSize = spriteRectSize,
        ImageRectOffset = spriteRectOffset,

        ImageColor3 = isGray and Color3.new(0.3,0.3,0.3) or Color3.new(1,1,1)
    }, {
        quantityLabel = quantityLabel
    })
end

return ItemLabel