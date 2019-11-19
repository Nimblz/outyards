local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("component")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local Dictionary = require(util:WaitForChild("Dictionary"))
local Selectors = require(common:WaitForChild("Selectors"))
local Thunks = require(common:WaitForChild("Thunks"))

local MenuBar = Roact.PureComponent:extend("MenuBar")
local MenuButton = require(script:WaitForChild("MenuButton"))
local CashLabel = require(script:WaitForChild("CashLabel"))
local withScale = require(component:WaitForChild("withScale"))

local PADDING = 16

local FrameWithScale = withScale("Frame")

function MenuBar:init()
    self.buttons = {
        {
            id = "inventory",
            icon = "rbxassetid://666448883",
            name = "Inventory",
        },
        {
            id = "crafting",
            icon = "rbxassetid://666448950",
            name = "Crafting",
        },
        {
            id = "boosts",
            icon = "rbxassetid://4102976956",
            name = "Premium Shop",
        },
        {
            id = "options",
            icon = "rbxassetid://282366832",
            name = "Options",
        },
    }

    self.buttonRefs = {}

    for idx, _ in pairs(self.buttons) do
        self.buttonRefs[idx] = Roact.createRef()
    end
end

function MenuBar:render()
    local visible = self.props.visible
    local currentView = self.props.currentView
    local buttons = {}

    buttons.layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0,PADDING),
        FillDirection = Enum.FillDirection.Vertical,
    })

    buttons.cash = Roact.createElement(CashLabel)

    for idx,buttonProps in pairs(self.buttons) do
        local id = buttonProps.id
        local callback = function()
            self.props.setView(currentView, id)
        end
        local active = currentView == id

        local props = Dictionary.join(buttonProps, {
            callback = callback,
            active = active,
            layoutOrder = idx + 1,

            buttonRef = self.buttonRefs[idx],
            downRef = self.buttonRefs[idx+1],
            upRef = self.buttonRefs[idx-1],
        })

        local newButton = Roact.createElement(MenuButton, props)
        buttons["button_"..idx] = newButton
    end

    return Roact.createElement(FrameWithScale, {
        Size = UDim2.new(0,100,0,0),
        Position = UDim2.new(0,PADDING,1,-PADDING),
        AnchorPoint = Vector2.new(0,1),
        BackgroundTransparency = 1,
        Visible = visible,
        ZIndex = 1,
    }, buttons)
end

local function mapStateToProps(state,props)
    return {
        currentView = Selectors.getView(state),
        visible = Selectors.getNavbarVisible(state),
    }
end

local function mapDispatchToProps(dispatch)
    return {
        setView = function(currentView,newView)
            if currentView == newView then
                dispatch(Thunks.VIEW_SET("default"))
            else
                dispatch(Thunks.VIEW_SET(newView))
            end
        end
    }
end

MenuBar = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(MenuBar)

return MenuBar