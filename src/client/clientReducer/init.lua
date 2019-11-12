local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local commonReducer = require(common.commonReducer)

local screenSize = require(script.screenSize)

local tooltipStrings = require(script.tooltipStrings)
local tooltipVisible = require(script.tooltipVisible)

local view = require(script.view)

local toolbarVisible = require(script.toolbarVisible)
local healthbarVisible = require(script.healthbarVisible)
local navbarVisible = require(script.navbarVisible)
local inventoryVisible = require(script.inventoryVisible)
local craftingVisible = require(script.craftingVisible)
local boostsVisible = require(script.boostsVisible)
local codesVisible = require(script.codesVisible)
local optionsVisible = require(script.optionsVisible)
local notifications = require(script.notifications)
local inventoryPage = require(script.inventoryPage)
local inventoryCatagory = require(script.inventoryCatagory)
local targetInteractable = require(script.targetInteractable)

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

        inventoryPage = inventoryPage(state.inventoryPage, action),
        inventoryCatagory = inventoryCatagory(state.inventoryCatagory, action),

        notifications = notifications(state.notifications, action),

        targetInteractable = targetInteractable(state.targetInteractable, action),
    })
end