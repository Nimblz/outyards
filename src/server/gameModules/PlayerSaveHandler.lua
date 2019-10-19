-- loads saves for players when they join, dispatches actions

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Actions = require(common:WaitForChild("Actions"))
local Thunks = require(common:WaitForChild("Thunks"))

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
            store:dispatch(Thunks.EQUIPMENT_APPLYSTATS(player))
            --store:dispatch(Actions.ITEM_ADD(player, "wood", 10))
            store:dispatch(Actions.ITEM_ADD(player, "crescendo", 1))
            store:dispatch(Actions.ITEM_ADD(player, "goldgodArmor", 1))
            store:dispatch(Actions.ITEM_ADD(player, "hermesboots", 1))
            store:dispatch(Actions.ITEM_ADD(player, "requiem", 1))
            store:dispatch(Actions.ITEM_ADD(player, "symphony", 1))
            store:dispatch(Actions.ITEM_ADD(player, "orchestra", 1))
            store:dispatch(Actions.ITEM_ADD(player, "superrocketlauncher", 1))
            store:dispatch(Actions.ITEM_ADD(player, "rocketlauncher", 1))
            store:dispatch(Actions.ITEM_ADD(player, "shotgun", 1))
            store:dispatch(Actions.ITEM_ADD(player, "uzi", 1))
            store:dispatch(Actions.ITEM_ADD(player, "longbow", 1))
            store:dispatch(Actions.ITEM_ADD(player, "scatterblaster", 1))
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