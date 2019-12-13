local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local event = ReplicatedStorage.event
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Items = require(common.Items)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local ItemInfo = require(component.ItemInfo)
local RoundFrame = require(component.RoundFrame)
local FancyButton = require(component.FancyButton)
local FitList = require(component.FitList)
local SpriteDisplay = require(component.SpriteDisplay)

local ItemFocus = Roact.PureComponent:extend("ItemFocus")

local eRequestEquip = event.eRequestEquip
local eRequestUnequip = event.eRequestUnequip

local function requestEquip(id)
    eRequestEquip:FireServer(id)
end

local function requestUnequip(id)
    eRequestUnequip:FireServer(id)
end

local function isItemEquippable(itemId)
    local item = Items.byId[itemId]
    if not item then return false end
    return item.equipmentType ~= nil
end

function ItemFocus:render()
    local itemId = self.props.itemId
    local item = Items.byId[itemId]
    local isEquipping = self.props.isEquipping

    local padding = Roact.createElement("UIPadding", {
        PaddingTop = UDim.new(0,16),
        PaddingBottom = UDim.new(0,16),
        PaddingLeft = UDim.new(0,16),
        PaddingRight = UDim.new(0,16),
    })

    local children

    if itemId and item and not isEquipping then
        local isEquipped = self.props.isEquipped
        local isEquippable = isItemEquippable(itemId)
        local isWeapon = item.equipmentType == "weapon"

        local function equip()
            if isWeapon then
                -- enable equipping mode
                self.props.setEquipping(true)
            else
                return requestEquip(itemId)
            end
        end

        local function unequip()
            return requestUnequip(itemId)
        end

        local equipColor = Color3.fromRGB(0, 255, 0)
        local unequipColor = Color3.fromRGB(255, 153, 0)

        local equipButton = isEquippable and Roact.createElement(FancyButton, {
            color = not isEquipped and equipColor or unequipColor,

            Size = UDim2.new(1,0,0,64),
            AnchorPoint = Vector2.new(0,1),
            Position = UDim2.new(0,0,1,0),

            [Roact.Event.Activated] = isEquipped and unequip or equip
        }, {
            textLabel = Roact.createElement("TextLabel", {
                Text = isEquipped and "Unequip!" or "Equip!",
                Size = UDim2.fromScale(1,1),
                BackgroundTransparency = 1,

                Font = Enum.Font.GothamBlack,
                TextSize = 32,
            })
        })

        local detailsContainer = Roact.createElement(FitList, {
            fitAxes = "Y",
            containerProps = {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1,0),
            },
            layoutProps = {
                Padding = UDim.new(0,4)
            }
        }, {
            spriteDisplay = Roact.createElement(SpriteDisplay, {
                spriteProps = {
                    itemId = itemId,
                }
            }),
            itemInfo = Roact.createElement(ItemInfo, {
                itemId = itemId,
            })
        })

        children = {
            padding = padding,
            detailsContainer = detailsContainer,
            equipButton = equipButton
        }
    elseif isEquipping then

        local equippingMessage = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBlack,
            TextSize = 32,
            TextWrapped = true,
            Text = "Click a toolbar slot to equip selected weapon!",
            TextColor3 = Color3.fromRGB(128, 128, 128),
            Size = UDim2.new(1,0,1,0),
        })

        children = {
            padding = padding,
            equippingMessage = equippingMessage
        }
    else -- no selection

        local noSelection = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBlack,
            TextSize = 32,
            TextWrapped = true,
            Text = "No item selected!",
            TextColor3 = Color3.fromRGB(200,200,200),
            Size = UDim2.new(1,0,1,0),
        })

        children = {
            padding = padding,
            noSelection = noSelection
        }
    end

    return Roact.createElement(RoundFrame, {
        ImageTransparency = 1,
        Size = UDim2.new(0,250,1,0),
        LayoutOrder = 2,
    }, children)
end

local function mapStateToProps(state, props)
    local itemId = Selectors.getSelectedItem(state)
    local isEquipping = Selectors.getIsEquipping(state)
    local isEquipped = Selectors.getIsEquipped(state, LocalPlayer, itemId)

    return {
        itemId = itemId,
        isEquipping = isEquipping,
        isEquipped = isEquipped,
    }
end

local function mapDispatchToProps(dispatch)
    return {
        setEquipping = function(bool)
            dispatch(Actions.ISEQUIPPING_SET(bool))
        end
    }
end

ItemFocus = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(ItemFocus)

return ItemFocus