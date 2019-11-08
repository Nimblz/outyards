local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local component = script.Parent
local view = component.view

local Roact = require(lib.Roact)

local App = Roact.Component:extend("App")
local Inventory = require(view.Inventory)
local Crafting = require(view.Crafting)
local Boosts = require(view.Boosts)
local Codes = require(view.Codes)
local Options = require(view.Options)
local Tooltip = require(component.Tooltip)
local MenuBar = require(component.MenuBar)
local HealthBar = require(component.HealthBar)
local NotificationContainer = require(component.NotificationContainer)
local AlphaWarning = require(component.AlphaWarning)
local AttackButton = require(component.AttackButton)
--local Toolbar = require(uiComponents.Toolbar)

function App:init()
    self._context.pzCore = self.props.pzCore
end

function App:didMount()
end

function App:render()
    local elements = {
        inventory = Roact.createElement(Inventory),
        crafting = Roact.createElement(Crafting),
        boosts = Roact.createElement(Boosts),
        codes = Roact.createElement(Codes),
        options = Roact.createElement(Options),
        tooltip = Roact.createElement(Tooltip),
        menubar = Roact.createElement(MenuBar),
        healthbar = Roact.createElement(HealthBar),
        notificationContainer = Roact.createElement(NotificationContainer),
        alphaWarning = Roact.createElement(AlphaWarning),
        attackButton = Roact.createElement(AttackButton),
        -- toolbar = Roact.createElement(Toolbar),
    }

    return Roact.createElement("ScreenGui",{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App