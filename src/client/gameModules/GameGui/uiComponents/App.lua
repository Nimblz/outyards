local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local uiComponents = script.Parent
local views = uiComponents:WaitForChild("views")

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
local Inventory = require(views:WaitForChild("Inventory"))
local Crafting = require(views:WaitForChild("Crafting"))
local Boosts = require(views:WaitForChild("Boosts"))
local Codes = require(views:WaitForChild("Codes"))
local Options = require(views:WaitForChild("Options"))
local Tooltip = require(uiComponents:WaitForChild("Tooltip"))
local MenuBar = require(uiComponents:WaitForChild("MenuBar"))
local HealthBar = require(uiComponents:WaitForChild("HealthBar"))
local NotificationContainer = require(uiComponents:WaitForChild("NotificationContainer"))
local AlphaWarning = require(uiComponents:WaitForChild("AlphaWarning"))
local AttackButton = require(uiComponents:WaitForChild("AttackButton"))
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