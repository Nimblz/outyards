-- applys move speed and health when stats change
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local PizzaAlpaca = require(lib.PizzaAlpaca)
local Selectors = require(common.Selectors)

local CharacterStatsApplier = PizzaAlpaca.GameModule:extend("CharacterStatsApplier")

function CharacterStatsApplier:applyStats(state,player)
    local playerData = Selectors.getPlayerState(state, player)
    if not playerData then return end

    local newMoveSpeed = Selectors.getMoveSpeed(state,player)
    local newDefense = Selectors.getDefense(state,player)

    local character = player.character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid.WalkSpeed = newMoveSpeed
    humanoid.MaxHealth = 100 + newDefense
    humanoid.Health = math.min(humanoid.Health, humanoid.MaxHealth)
end

function CharacterStatsApplier:onStore(store)
    store.changed:connect(function(newState,oldState)
        for _, player in pairs(Players:GetPlayers()) do
            self:applyStats(newState,player)
        end
    end)

    Players.PlayerAdded:connect(function(player)
        player.CharacterAdded:connect(function()
            self:applyStats(store:getState(),player)
        end)
    end)
end

function CharacterStatsApplier:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)
end

return CharacterStatsApplier