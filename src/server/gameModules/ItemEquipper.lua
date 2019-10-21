local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Thunks = require(common:WaitForChild("Thunks"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ItemEquipper = PizzaAlpaca.GameModule:extend("ItemEquipper")

local eRequestEquip = event:WaitForChild("eRequestEquip")
local eRequestUnequip = event:WaitForChild("eRequestUnequip")

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