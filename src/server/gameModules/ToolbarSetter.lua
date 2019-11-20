local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Thunks = require(common.Thunks)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local ItemEquipper = PizzaAlpaca.GameModule:extend("ItemEquipper")

local eRequestToolbarSet = event.eRequestToolbarSet

function ItemEquipper:onStore(store)
    eRequestToolbarSet.OnServerEvent:connect(function(player, index, itemId)
        assert(typeof(index) == "number")
        assert(typeof(itemId) == "number")

        store:dispatch(Thunks.TOOLBAR_SET(player, index, itemId))
    end)
end

function ItemEquipper:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return ItemEquipper