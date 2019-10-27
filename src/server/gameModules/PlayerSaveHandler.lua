-- loads saves for players when they join, dispatches actions

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Actions = require(common:WaitForChild("Actions"))
local Thunks = require(common:WaitForChild("Thunks"))
local Selectors = require(common:WaitForChild("Selectors"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PlayerSaveHandler = PizzaAlpaca.GameModule:extend("PlayerSaveHandler")

local eInitialState = event:WaitForChild("eInitialState")

function PlayerSaveHandler:preInit()
end

function PlayerSaveHandler:init()
    local storeContainer = self.core:getModule("StoreContainer")

    storeContainer:getStore():andThen(function(store)

        local function playerAdded(player)
            store:dispatch(Thunks.PLAYER_JOINED(player))

            if Selectors.getItem(store:getState(), player, "goldScoobisPet") == 0 then
                store:dispatch(Actions.ITEM_ADD(player, "goldScoobisPet", 1))
            end

            local newState = store:getState()
            eInitialState:FireClient(player,newState)

            store:dispatch(Thunks.EQUIPMENT_APPLYSTATS(player))
        end

        local function playerLeaving(player)
            store:dispatch(Thunks.PLAYER_LEAVING(player))
        end

        Players.PlayerAdded:connect(playerAdded)
        Players.PlayerRemoving:connect(playerLeaving)

        for _, player in pairs(Players:GetPlayers()) do
            playerAdded(player)
        end
    end)
end

function PlayerSaveHandler:postInit()
end

return PlayerSaveHandler