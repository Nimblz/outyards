-- loads saves for players when they join, dispatches actions

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Actions = require(common.Actions)
local Thunks = require(common.Thunks)
local Selectors = require(common.Selectors)

local Signal = require(lib.Signal)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local PlayerSaveHandler = PizzaAlpaca.GameModule:extend("PlayerSaveHandler")

local eInitialState = event.eInitialState
local eClientReady = event.eClientReady

function PlayerSaveHandler:create()
    self.playerLoaded = Signal.new()
end

function PlayerSaveHandler:init()
    local storeContainer = self.core:getModule("StoreContainer")

    local loaded = {}

    storeContainer:getStore():andThen(function(store)

        local function playerAdded(player)
            if loaded[player] == true then return end
            store:dispatch(Thunks.PLAYER_JOINED(player))

            if Selectors.getItem(store:getState(), player, "goldScoobisPet") == 0 then
                store:dispatch(Actions.ITEM_ADD(player, "goldScoobisPet", 1))
            end

            local newState = store:getState()
            eInitialState:FireClient(player,newState)
            loaded[player] = true

            store:dispatch(Thunks.EQUIPMENT_APPLYSTATS(player))
            self.playerLoaded:fire(player)
        end

        local function playerLeaving(player)
            loaded[player] = nil
            store:dispatch(Thunks.PLAYER_LEAVING(player))
        end

        eClientReady.OnServerEvent:connect(playerAdded)
        Players.PlayerRemoving:connect(playerLeaving)
    end)
end

function PlayerSaveHandler:postInit()
end

return PlayerSaveHandler