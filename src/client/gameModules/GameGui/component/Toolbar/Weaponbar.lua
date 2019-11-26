local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")
local util = common.util
local event = ReplicatedStorage.event

local eRequestToolbarSet = event.eRequestToolbarSet
local eRequestEquip = event.eRequestEquip
local eRequestUnequip = event.eRequestUnequip

local Selectors = require(common.Selectors)
local Actions = require(common.Actions)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local FitList = require(component.FitList)
local ToolbarButton = require(script.Parent.ToolbarButton)

local Weaponbar = Roact.Component:extend("Weaponbar")

function Weaponbar:handleClick(index)
    -- if in equipping mode then request a set for the selected item id
    local isEquipping = self.props.isEquipping
    local selectedItem = self.props.selectedItem
    local toolbarItems = self.props.toolbarItems
    local itemId = toolbarItems[index]

    if isEquipping then
        print("Requesting toolbar set!")
        eRequestToolbarSet:FireServer(index, selectedItem)
        self.props.setEquipping(false)
    elseif itemId then
        local isEquipped = self.props.itemIsEquipped(itemId)

        if not isEquipped then
            print("Requesting equip!")
            eRequestEquip:FireServer(itemId)
        else
            eRequestUnequip:FireServer(itemId)
        end
    end
end

function Weaponbar:init()

    local function actionHandler(index, state)
        if state == Enum.UserInputState.Begin then
            self:handleClick(index)
        end
    end

    local keyCodes = {
        Enum.KeyCode.One,
        Enum.KeyCode.Two,
        Enum.KeyCode.Three,
        Enum.KeyCode.Four,
    }

    -- bind one thru four to simulate hotbar clicks
    for idx, key in ipairs(keyCodes) do
        ContextActionService:BindAction("TOOLBAR_"..idx,
            function(name, state) actionHandler(idx, state) end,
            false,
            key
        )
    end
end

function Weaponbar:willUnmount()
    -- unbind keys
    for idx = 1, 4 do
        ContextActionService:UnbindAction("TOOLBAR_"..idx)
    end
end

function Weaponbar:render()
    local toolbarItems = self.props.toolbarItems
    local mainButtons = {}

    for index = 1, 4 do
        mainButtons["weapon_"..index] = Roact.createElement(ToolbarButton, {
            index = index,
            itemId = toolbarItems[index],
            onClick = function(clickedIndex)
                self:handleClick(clickedIndex)
            end,
        })
    end

    return Roact.createElement(FitList, {
        containerKind = "Frame",
        paddingProps = {
            PaddingTop = UDim.new(0,0),
            PaddingBottom = UDim.new(0,0),
            PaddingLeft = UDim.new(0,0),
            PaddingRight = UDim.new(0,0),
        },
        layoutProps = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0,16),
        },
        containerProps = {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
        },
    }, mainButtons)
end

local function mapStateToProps(state, props)
    return {
        toolbarItems = Selectors.getToolbar(state, LocalPlayer),
        selectedItem = Selectors.getSelectedItem(state),
        isEquipping = Selectors.getIsEquipping(state),
        itemIsEquipped = function(itemId) return Selectors.getIsEquipped(state, LocalPlayer, itemId) end
    }
end

local function mapDispatchToProps(dispatch)
    return {
        setEquipping = function(bool)
            dispatch(Actions.ISEQUIPPING_SET(bool))
        end
    }
end

Weaponbar = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Weaponbar)

return Weaponbar