local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local components = script:FindFirstAncestor("uiComponents")
local util = common:WaitForChild("util")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))
local Items = require(common:WaitForChild("Items"))
local Sprites = require(common:WaitForChild("Sprites"))
local Actions = require(common:WaitForChild("Actions"))
local Selectors = require(common:WaitForChild("Selectors"))

local beautifyNumber = require(util:WaitForChild("beautifyNumber"))

local eRequestEquip = event:WaitForChild("eRequestEquip")
local eRequestUnequip = event:WaitForChild("eRequestUnequip")

local RoundFrame = require(components:WaitForChild("RoundFrame"))
local ItemLabel = Roact.Component:extend("ItemLabel")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

local function capitalize(string)
    return string:sub(1,1):upper()..string:sub(2)
end

function ItemLabel:init()
end

function ItemLabel:didMount()
end

function ItemLabel:render()
    local itemId = self.props.itemId
    local quantity = self.props.quantity
    local isGray = self.props.isGray
    local layoutOrder = self.props.layoutOrder or 0
    local showTooltip = self.props.showTooltip
    local activatable = self.props.activatable or false
    local equipped = self.props.isEquipped and activatable

    if showTooltip == nil then
        showTooltip = true
    end

    local item = Items.byId[itemId]
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteRectSize = spriteSheet.spriteSize * spriteSheet.scaleFactor
    local spriteRectOffset = Vector2.new(
        (item.spriteCoords.X-1) * spriteSheet.spriteSize.X,
        (item.spriteCoords.Y-1) * spriteSheet.spriteSize.Y
    )   * spriteSheet.scaleFactor

    local itemName = item.name or itemId

    local quantityLabel
    if quantity then
        quantityLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(0,24,0,24),
            AnchorPoint = Vector2.new(1,1),
            Position = UDim2.new(1,-4,1,-4),
            BackgroundTransparency = 1,
            Text = beautifyNumber(quantity,nil,nil,1),
            TextSize = 16,
            TextColor3 = Color3.new(1,1,1),
            TextStrokeTransparency = 0,
            Font = Enum.Font.GothamBlack,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextYAlignment = Enum.TextYAlignment.Bottom,
            ZIndex = 3
        })
    end

    local equippedLabel
    if equipped then
        equippedLabel = Roact.createElement("Frame", {
            Size = UDim2.new(0,12,0,12),
            Position = UDim2.new(0,4,0,4),
            BackgroundColor3 = Color3.fromRGB(0, 207, 0),
            BorderSizePixel = 2,
            Rotation = 45,
        })
    end

    local thumbStrings = {}
    local spacer = ("- "):rep(20):sub(1,39)

    table.insert(thumbStrings,item.name)
    table.insert(thumbStrings,item.desc)
    table.insert(thumbStrings,item.equipmentType and "Type: "..item.equipmentType)

    if item.stats then
        table.insert(thumbStrings, spacer)
    end

    for stat,value in pairs(item.stats or {}) do
        local newString = ("%s: %s"):format(capitalize(stat),tostring(value))
        table.insert(thumbStrings,newString)
    end

    table.insert(thumbStrings, spacer)
    table.insert(thumbStrings, "[Item id: "..item.id.."]")

    local itemButton = Roact.createElement(activatable and "ImageButton" or "ImageLabel", {
        Size = UDim2.new(0,spriteSheet.spriteSize.X * 3,0,spriteSheet.spriteSize.Y * 3),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),

        Image = spriteSheet.assetId,
        ImageRectSize = spriteRectSize,
        ImageRectOffset = spriteRectOffset,

        Selectable = activatable,

        ImageColor3 = isGray and Color3.new(0.3,0.3,0.3) or Color3.new(1,1,1),
        [Roact.Event.MouseEnter] = showTooltip and function() self.props.displayTooltip(thumbStrings) end or nil,
        [Roact.Event.MouseLeave] = showTooltip and function() self.props.hideTooltip() end or nil,
        [Roact.Event.SelectionGained] = showTooltip and function() self.props.displayTooltip(thumbStrings) end or nil,
        [Roact.Event.SelectionLost] = showTooltip and function() self.props.hideTooltip() end or nil,
        [Roact.Event.Activated] = activatable and function()
            if not equipped then
                eRequestEquip:FireServer(itemId)
            else
                print("trying to unequip")
                eRequestUnequip:FireServer(itemId)
            end
        end or nil,
    }, {
        equippedLabel = equippedLabel,
    })

    return Roact.createElement(RoundFrame, {
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(0,58,0,58),
        LayoutOrder = layoutOrder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5,0,0.5,0),
    }, {
        [itemId.."_icon"] = itemButton,
        quantityLabel = quantityLabel,
    })
end

ItemLabel = RoactRodux.connect(function(state,props)
    return {
        isEquipped = Selectors.getIsEquipped(state,LocalPlayer,props.itemId)
    }
end, function(dispatch)
    return {
        displayTooltip = function(strings)
            strings = strings or {}
            dispatch(Actions.TOOLTIP_STRINGS_SET(strings))
            dispatch(Actions.TOOLTIP_VISIBLE_SET(true))
        end,
        hideTooltip = function()
            dispatch(Actions.TOOLTIP_VISIBLE_SET(false))
        end
    }
end)(ItemLabel)

return ItemLabel