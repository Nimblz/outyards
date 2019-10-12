local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
local CashLabel = require(uiComponents:WaitForChild("CashLabel"))
local HealthBar = require(uiComponents:WaitForChild("HealthBar"))
local Inventory = require(uiComponents:WaitForChild("PrototypeInventory"))
local Crafting = require(uiComponents:WaitForChild("PrototypeCrafting"))
local Tooltip = require(uiComponents:WaitForChild("Tooltip"))
local MenuBar = require(uiComponents:WaitForChild("MenuBar"))
local StatsBar = require(uiComponents:WaitForChild("StatsBar"))
--local Equipment = require(uiComponents:WaitForChild("Equipment"))
--local WeaponBar = require(uiComponents:WaitForChild("WeaponBar"))

function App:init()
end

function App:didMount()
end

function App:render()
    local elements = {
        --cashLabel = Roact.createElement(CashLabel),
        inventory = Roact.createElement(Inventory),
        crafting = Roact.createElement(Crafting),
        tooltip = Roact.createElement(Tooltip),
        -- menubar = Roact.createElement(MenuBar),
        statsbar = Roact.createElement(StatsBar),
        healthbar = Roact.createElement(HealthBar),
    }

    return Roact.createElement("ScreenGui",{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App