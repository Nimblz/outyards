local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local commonReducer = require(common:WaitForChild("commonReducer"))

local screenSize = require(script:WaitForChild("screenSize"))

local tooltipStrings = require(script:WaitForChild("tooltipStrings"))
local tooltipVisible = require(script:WaitForChild("tooltipVisible"))

local view = require(script:WaitForChild("view"))

local toolbarVisible = require(script:WaitForChild("toolbarVisible"))
local healthbarVisible = require(script:WaitForChild("healthbarVisible"))
local navbarVisible = require(script:WaitForChild("navbarVisible"))
local inventoryVisible = require(script:WaitForChild("inventoryVisible"))
local craftingVisible = require(script:WaitForChild("craftingVisible"))
local boostsVisible = require(script:WaitForChild("boostsVisible"))
local codesVisible = require(script:WaitForChild("codesVisible"))
local optionsVisible = require(script:WaitForChild("optionsVisible"))
local notifications = require(script:WaitForChild("notifications"))

return function(state, action)
    state = state or {}

    return Dictionary.join(commonReducer(state,action), {
        screenSize = screenSize(state.screenSize, action),
        view = view(state.view, action),

        tooltipStrings = tooltipStrings(state.tooltipStrings, action),
        tooltipVisible = tooltipVisible(state.tooltipVisible, action),

        inventoryVisible = inventoryVisible(state.inventoryVisible, action),
        craftingVisible = craftingVisible(state.craftingVisible, action),
        boostsVisible = boostsVisible(state.boostsVisible, action),
        codesVisible = codesVisible(state.codesVisible, action),
        optionsVisible = optionsVisible(state.optionsVisible, action),

        navbarVisible = navbarVisible(state.navbarVisible, action),
        toolbarVisible = toolbarVisible(state.toolbarVisible, action),
        healthbarVisible = healthbarVisible(state.healthbarVisible, action),

        notifications = notifications(state.notifications, action),
    })
end