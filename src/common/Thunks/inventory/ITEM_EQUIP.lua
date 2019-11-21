local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local thunks = script:FindFirstAncestor("Thunks")
local stats = thunks.stats

local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local EQUIPMENT_APPLYSTATS = require(stats.EQUIPMENT_APPLYSTATS)

return function(player,itemToEquip)
    return function (store)
        local state = store:getState()

        local doesHave = Selectors.getItem(state, player, itemToEquip) > 0

        if doesHave then
            store:dispatch(Actions.EQUIPMENT_EQUIP(player, itemToEquip))
            store:dispatch(EQUIPMENT_APPLYSTATS(player))
            print(("Successfully equipped [%s] to [%s]"):format(itemToEquip, player.Name))
        else
            print(("[%s] tried to equip [%s] but does not own it."):format(player.Name, itemToEquip))
        end
    end
end