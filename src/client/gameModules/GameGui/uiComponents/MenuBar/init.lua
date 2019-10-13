local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))

local MenuBar = Roact.Component:extend("MenuBar")
local MenuButton = require(script:WaitForChild("MenuButton"))

local PADDING = 16

function MenuBar:init()
end

function MenuBar:didMount()
end

function MenuBar:render()
    local menuButtons = self.props.menuButtons or {
        shop = {
            icon = "rbxassetid://4102976956",
            layoutOrder = 1
        },
        crafting = {
            icon = "rbxassetid://666448950",
            layoutOrder = 2
        },
        inventory = {
            icon = "rbxassetid://666448883",
            layoutOrder = 3
        },
        options = {
            icon = "rbxassetid://282366832",
            layoutOrder = 4
        },
    }
    local buttons = {}

    buttons.layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0,PADDING),
        FillDirection = Enum.FillDirection.Vertical,
    })

    for idx,buttonProps in pairs(menuButtons) do
        local newButton = Roact.createElement(MenuButton, buttonProps)
        buttons["button_"..idx] = newButton
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,100,0,0),
        Position = UDim2.new(0,PADDING,1,-PADDING),
        AnchorPoint = Vector2.new(0,1),
        BackgroundTransparency = 1,
    }, buttons)
end

return MenuBar