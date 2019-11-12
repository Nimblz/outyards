local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Items = require(common.Items)
local Sprites = require(common.Sprites)
local Actions = require(common.Actions)
local Selectors = require(common.Selectors)

local beautifyNumber = require(util.beautifyNumber)

local SpriteLabel = require(component.SpriteLabel)
local RoundButton = require(component.RoundButton)

local ItemButton = Roact.PureComponent:extend("ItemButton")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

local function capitalize(string)
    return string:sub(1,1):upper()..string:sub(2)
end

function ItemButton:activated(rbx)
    if self.props.onActivated then self.props.onActivated(rbx, self.props.itemId) end
end

function ItemButton:hovered(rbx)
    if self.props.onHovered then self.props.onHovered(rbx) end
end

function ItemButton:unhovered(rbx)
    if self.props.onUnhovered then self.props.onUnhovered(rbx) end
end

function ItemButton:getTooltipStrings()
    local tipStrings = {}
    local spacer = "$SEPARATOR"

    local itemId = self.props.itemId
    local item = Items.byId[itemId]

    if not item then
        return {
            "Invalid item :(",
            "[Item id: "..item.id.."]",
        }
    end

    table.insert(tipStrings,item.name)
    table.insert(tipStrings,item.desc)
    table.insert(tipStrings,item.equipmentType and "Type: "..item.equipmentType)

    if item.stats then
        table.insert(tipStrings, spacer)
    end

    for stat,value in pairs(item.stats or {}) do
        local newString = ("%s: %s"):format(capitalize(stat),tostring(value))
        table.insert(tipStrings,newString)
    end

    table.insert(tipStrings, spacer)
    table.insert(tipStrings, "[Item id: "..item.id.."]")

    return tipStrings
end

function ItemButton:showTooltip()
    local strings = self:getTooltipStrings()

    self.props.displayTooltip(strings)
end

function ItemButton:hideTooltip()
    self.props.hideTooltip()
end

function ItemButton:render()
    local itemId = self.props.itemId
    local layoutOrder = self.props.layoutOrder
    local isHidden = self.props.isHidden
    local scale = self.props.scale or 4
    local quantity = self.props.quantity
    local padding = self.props.padding or 4
    local showQuantity = not self.props.hideQuantity
    local showEquipped = not self.props.hideEquipped
    local isEquipped = self.props.isEquipped or false
    local color = self.props.color

    local item = Items.byId[itemId]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteSize = spriteSheet.spriteSize
    local backgroundFrameSize = (spriteSize * scale) + Vector2.new(padding*2, padding*2)

    local spriteLabel = Roact.createElement(SpriteLabel, {
        itemId = itemId,
        layoutOrder = layoutOrder,
        color = isHidden and Color3.new(0.2, 0.2, 0.2),
        scale = scale,
    })

    local quantityLabel = showQuantity and Roact.createElement("TextLabel", {
        Size = UDim2.new(0,24,0,24),
        AnchorPoint = Vector2.new(1,1),
        Position = UDim2.new(1,-4,1,-4),
        BackgroundTransparency = 1,
        Text = beautifyNumber(quantity, nil, nil, 1),
        TextSize = 20,
        TextColor3 = Color3.new(1,1,1),
        TextStrokeTransparency = 0,
        Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        ZIndex = 3
    })

    local equippedIndicator = isEquipped and showEquipped and Roact.createElement("ImageLabel", {
        Image = "rbxassetid://4360912343",

        AnchorPoint = Vector2.new(0,1),
        Position = UDim2.new(0,8,1,-8),
        Size = UDim2.fromOffset(24,24),

        BackgroundTransparency = 1,
    })

    return Roact.createElement(RoundButton, {
        color = color,

        Size = UDim2.fromOffset(backgroundFrameSize.X, backgroundFrameSize.Y),
        Position = self.props.Position,
        AnchorPoint = self.props.AnchorPoint,

        [Roact.Event.Activated] = function(rbx) self:activated(rbx) end,
        [Roact.Event.MouseEnter] = function(rbx) self:hovered(rbx) self:showTooltip() end,
        [Roact.Event.MouseLeave] = function(rbx) self:unhovered(rbx) self:hideTooltip() end,
        [Roact.Event.SelectionGained] = function(rbx) self:showTooltip() end,
        [Roact.Event.SelectionLost] = function(rbx) self:hideTooltip() end or nil,
    }, {
        sprite = spriteLabel,
        quantity = quantityLabel,
        equippedIndicator = equippedIndicator,
    })
end

local function mapStateToProps(state, props)
    return {
        isEquipped = Selectors.getIsEquipped(state, LocalPlayer,props.itemId)
    }
end

local function mapDispatchToProps(dispatch)
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
end

ItemButton = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(ItemButton)

return ItemButton