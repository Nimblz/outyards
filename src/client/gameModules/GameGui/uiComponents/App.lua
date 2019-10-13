local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
local HealthBar = require(uiComponents:WaitForChild("HealthBar"))
--local Inventory = require(uiComponents:WaitForChild("Inventory"))
--local Crafting = require(uiComponents:WaitForChild("Crafting"))
local Tooltip = require(uiComponents:WaitForChild("Tooltip"))
local MenuBar = require(uiComponents:WaitForChild("MenuBar"))
--local WeaponBar = require(uiComponents:WaitForChild("WeaponBar"))

function App:init()
end

function App:didMount()
end

function App:render()
    local elements = {
        -- inventory = Roact.createElement(Inventory),
        -- crafting = Roact.createElement(Crafting),
        tooltip = Roact.createElement(Tooltip),
        menubar = Roact.createElement(MenuBar),
        healthbar = Roact.createElement(HealthBar),
    }

    return Roact.createElement("ScreenGui",{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App