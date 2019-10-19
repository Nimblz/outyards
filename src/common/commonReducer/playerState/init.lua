local inventory = require(script:WaitForChild("inventory"))
local equipped = require(script:WaitForChild("equipped"))
local stats = require(script:WaitForChild("stats"))
local toolbar = require(script:WaitForChild("toolbar"))

return function(state,action)
    state = state or {}

    -- server TODO: break this into two reducers?
    if action.type == "PLAYER_ADD" then -- load save data
        state = action.saveData
    end

    if action.type == "PLAYER_REMOVE" then -- bye bye
        return nil
    end

    return {
        inventory = inventory(state.inventory, action),
        equipped = equipped(state.equipped, action),
        stats = stats(state.stats, action),
        toolbar = toolbar(state.toolbar, action),
    }
end