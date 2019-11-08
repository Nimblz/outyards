-- loads saves for players when they join, dispatches actions

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local eRequestCraft = event.eRequestCraft

local Thunks = require(common.Thunks)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local Crafting = PizzaAlpaca.GameModule:extend("Crafting")

function Crafting:init()
    local storeContainer = self.core:getModule("StoreContainer")

    storeContainer:getStore():andThen(function(store)
        eRequestCraft.OnServerEvent:connect(function(player, itemId)
            store:dispatch(Thunks.ITEM_CRAFT(player, itemId))
        end)
    end)
end

return Crafting