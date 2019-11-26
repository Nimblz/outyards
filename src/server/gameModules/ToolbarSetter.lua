local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Thunks = require(common.Thunks)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local ToolbarSetter = PizzaAlpaca.GameModule:extend("ToolbarSetter")

local eRequestToolbarSet = event.eRequestToolbarSet

function ToolbarSetter:onStore(store)
    eRequestToolbarSet.OnServerEvent:connect(function(player, index, itemId)
        assert(typeof(index) == "number")
        assert(typeof(itemId) == "string")

        store:dispatch(Thunks.TOOLBAR_SET(player, index, itemId))
    end)
end

function ToolbarSetter:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return ToolbarSetter