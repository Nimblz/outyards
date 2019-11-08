-- PLAYER_LEAVING thunk
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Actions = require(common.Actions)

local PLAYER_REMOVE = Actions.PLAYER_REMOVE

return function(player)
    return function(store)
        store:dispatch(PLAYER_REMOVE(player))
    end
end