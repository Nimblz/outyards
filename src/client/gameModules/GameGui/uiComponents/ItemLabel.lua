local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local Items = require(common:WaitForChild("Items"))

local ItemLabel = Roact.Component:extend("ItemLabel")

local errors = {
    invalidItemId = "Invalid itemId [%s]!"
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

    assert(item, errors.invalidItemId:format(tostring(itemId)))

    return Roact.createElement("TextLabel", {
        Text = " "..(item.name or itemId).." - "..tostring(quantity),
        Size = UDim2.new(1,0,0,40),
        BorderSizePixel = 0,
        BackgroundColor3 = isGray and Color3.new(0.7,0.7,0.7) or Color3.new(1,1,1),
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        LayoutOrder = layoutOrder,
    })
end

return ItemLabel