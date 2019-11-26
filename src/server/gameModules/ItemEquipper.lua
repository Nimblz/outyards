local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Thunks = require(common.Thunks)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local ItemEquipper = PizzaAlpaca.GameModule:extend("ItemEquipper")

local eRequestEquip = event.eRequestEquip
local eRequestUnequip = event.eRequestUnequip

function ItemEquipper:onStore(store)
    eRequestEquip.OnServerEvent:connect(function(player, itemId)
        store:dispatch(Thunks.ITEM_EQUIP(player,itemId))
    end)
    eRequestUnequip.OnServerEvent:connect(function(player, itemId)
        store:dispatch(Thunks.ITEM_UNEQUIP(player,itemId))
    end)
end

function ItemEquipper:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return ItemEquipper