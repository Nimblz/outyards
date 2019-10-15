local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local Selectors = require(common:WaitForChild("Selectors"))
local Thunks = require(common:WaitForChild("Thunks"))

local MenuBar = Roact.PureComponent:extend("MenuBar")
local MenuButton = require(script:WaitForChild("MenuButton"))
local CashLabel = require(script:WaitForChild("CashLabel"))

local PADDING = 16

function MenuBar:render()
    local visible = self.props.visible
    local currentView = self.props.currentView
    local buttons = {}

    local menuButtons = {
        inventory = {
            icon = "rbxassetid://666448883",
            name = "Inventory",
            layoutOrder = 2
        },
        crafting = {
            icon = "rbxassetid://666448950",
            name = "Crafting",
            layoutOrder = 3
        },
        boosts = {
            icon = "rbxassetid://4102976956",
            name = "Premium Shop",
            layoutOrder = 4
        },
        -- codes = {
        --     icon = "rbxassetid://391745819",
        --     name = "Social Codes",
        --     layoutOrder = 5
        -- },
        options = {
            icon = "rbxassetid://282366832",
            name = "Options",
            layoutOrder = 5
        },
    }

    buttons.layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0,PADDING),
        FillDirection = Enum.FillDirection.Vertical,
    })

    buttons.cash = Roact.createElement(CashLabel)

    for idx,buttonProps in pairs(menuButtons) do
        buttonProps.callback = function()
            self.props.setView(currentView, idx)
        end
        buttonProps.active = currentView == idx
        local newButton = Roact.createElement(MenuButton, buttonProps)
        buttons["button_"..idx] = newButton
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,100,0,0),
        Position = UDim2.new(0,PADDING,1,-PADDING),
        AnchorPoint = Vector2.new(0,1),
        BackgroundTransparency = 1,
        Visible = visible
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