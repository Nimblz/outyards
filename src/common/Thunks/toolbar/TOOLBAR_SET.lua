local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

return function(player, index, itemId)
    return function (store)
        local state = store:getState()

        local doesHave = Selectors.getItem(state, player, itemId) > 0

        if doesHave then
            store:dispatch(Actions.TOOLBAR_SET(player, index, itemId))
        end
    end
end