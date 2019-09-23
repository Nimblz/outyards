local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
local CashLabel = require(uiComponents:WaitForChild("CashLabel"))
--local HealthBar = require(uiComponents:WaitForChild("HealthBar"))
--local Navbar = require(uiComponents:WaitForChild("Navbar"))
--local Inventory = require(uiComponents:WaitForChild("Inventory"))
--local Crafting = require(uiComponents:WaitForChild("Crafting"))
--local Equipment = require(uiComponents:WaitForChild("Equipment"))
--local WeaponBar = require(uiComponents:WaitForChild("WeaponBar"))

function App:init()
end

function App:didMount()
end

function App:render()

    local elements = {
        cashLabel = Roact.createElement(CashLabel),
    }

    return Roact.createElement("ScreenGui",{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App