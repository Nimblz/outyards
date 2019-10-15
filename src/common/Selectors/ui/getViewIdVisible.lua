local ui = script.Parent

local getInventoryVisible = require(ui:WaitForChild("getInventoryVisible"))
local getCraftingVisible = require(ui:WaitForChild("getCraftingVisible"))
local getBoostsVisible = require(ui:WaitForChild("getBoostsVisible"))
local getCodesVisible = require(ui:WaitForChild("getCodesVisible"))
local getHealthbarVisible = require(ui:WaitForChild("getHealthbarVisible"))
local getToolbarVisible = require(ui:WaitForChild("getToolbarVisible"))
local getOptionsVisible = require(ui:WaitForChild("getOptionsVisible"))

local viewSelectors = {
    inventory = getInventoryVisible,
    crafting = getCraftingVisible,
    boosts = getBoostsVisible,
    codes = getCodesVisible,
    healthbar = getHealthbarVisible,
    toolbar = getToolbarVisible,
    options = getOptionsVisible,
}

return function(state,viewId)
    return viewSelectors[viewId](state)
end