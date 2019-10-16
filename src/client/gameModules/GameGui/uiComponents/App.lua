local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local uiComponents = script.Parent
local legacy = uiComponents:WaitForChild("legacy")
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
local withScale = require(uiComponents:WaitForChild("withScale"))
--local Toolbar = require(uiComponents:WaitForChild("Toolbar"))

local ProtoCrafting = require(legacy:WaitForChild("PrototypeCrafting"))

function App:init()
end

function App:didMount()
end

function App:render()
    local elements = {
        inventory = Roact.createElement(Inventory),
        crafting = Roact.createElement(ProtoCrafting),
        boosts = Roact.createElement(Boosts),
        codes = Roact.createElement(Codes),
        options = Roact.createElement(Options),
        tooltip = Roact.createElement(Tooltip),
        menubar = Roact.createElement(MenuBar),
        healthbar = Roact.createElement(HealthBar),
        notificationContainer = Roact.createElement(NotificationContainer)
        -- toolbar = Roact.createElement(Toolbar)
    }

    return Roact.createElement(withScale("ScreenGui"),{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App