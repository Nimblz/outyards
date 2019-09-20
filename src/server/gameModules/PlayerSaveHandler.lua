-- loads saves for players when they join, dispatches actions

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Actions = require(common:WaitForChild("Actions"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local PlayerSaveHandler = PizzaAlpaca.GameModule:extend("PlayerSaveHandler")

local eInitialState = event:WaitForChild("eInitialState")

function PlayerSaveHandler:preInit()
end

function PlayerSaveHandler:init()
    local storeContainer = self.core:getModule("StoreContainer")

    storeContainer:getStore():andThen(function(store)

        local function playerAdded(player)
            store:dispatch(Actions.PLAYER_ADD(player,{}))
            local newState = store:getState()
            eInitialState:FireClient(player,newState)

            delay(5,function()
                store:dispatch(Actions.CASH_ADD(player,500))
            end)
        end

        Players.PlayerAdded:connect(playerAdded)

        for _, player in pairs(Players:GetPlayers()) do
            playerAdded(player)
        end
    end)
end

function PlayerSaveHandler:postInit()
end

return PlayerSaveHandler