local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")

local Items = require(common:WaitForChild("Items"))
local Actions = require(common:WaitForChild("Actions"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local contains = require(util:WaitForChild("contains"))

local AdminCommands = PizzaAlpaca.GameModule:extend("AdminCommands")

function AdminCommands:create()
    self.handlers = {
        ["gimmiebeans"] = function(player)
            -- give player 100 of every item
            local storeContainer = self.core:getModule("StoreContainer")

            storeContainer:getStore():andThen(function(store)
                for _, item in pairs(Items.all) do
                    store:dispatch(Actions.ITEM_ADD(player, item.id, 1))
                end
            end)
        end,
        ["hooh"] = function(player)

        end,
    }
    self.admins = {
        2246184,
    }
end

function AdminCommands:onChatted(player, message)
    -- check if player is an admin
    if contains(self.admins, player.UserId) then
        for string, handler in pairs(self.handlers) do
            if message == string then
                handler(player)
            end
        end
    end
end

function AdminCommands:playerAdded(player)
    player.Chatted:connect(function(msg)
        self:onChatted(player, msg)
    end)
end

function AdminCommands:init()
    Players.PlayerAdded:connect(function(player)
        self:playerAdded(player)
    end)

    for _, player in pairs(Players:GetPlayers()) do
        self:playerAdded(player)
    end
end

return AdminCommands