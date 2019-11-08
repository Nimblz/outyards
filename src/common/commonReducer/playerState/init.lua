local inventory = require(script.inventory)
local equipped = require(script.equipped)
local stats = require(script.stats)
local toolbar = require(script.toolbar)

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