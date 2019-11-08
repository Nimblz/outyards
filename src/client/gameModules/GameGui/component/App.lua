local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local component = script.Parent
local view = component:WaitForChild("view")

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
local Inventory = require(view:WaitForChild("Inventory"))
local Crafting = require(view:WaitForChild("Crafting"))
local Boosts = require(view:WaitForChild("Boosts"))
local Codes = require(view:WaitForChild("Codes"))
local Options = require(view:WaitForChild("Options"))
local Tooltip = require(component:WaitForChild("Tooltip"))
local MenuBar = require(component:WaitForChild("MenuBar"))
local HealthBar = require(component:WaitForChild("HealthBar"))
local NotificationContainer = require(component:WaitForChild("NotificationContainer"))
local AlphaWarning = require(component:WaitForChild("AlphaWarning"))
local AttackButton = require(component:WaitForChild("AttackButton"))
--local Toolbar = require(uiComponents:WaitForChild("Toolbar"))

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