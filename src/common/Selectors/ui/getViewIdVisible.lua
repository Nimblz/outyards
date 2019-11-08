local ui = script.Parent

local getInventoryVisible = require(ui.getInventoryVisible)
local getCraftingVisible = require(ui.getCraftingVisible)
local getBoostsVisible = require(ui.getBoostsVisible)
local getCodesVisible = require(ui.getCodesVisible)
local getHealthbarVisible = require(ui.getHealthbarVisible)
local getToolbarVisible = require(ui.getToolbarVisible)
local getOptionsVisible = require(ui.getOptionsVisible)

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