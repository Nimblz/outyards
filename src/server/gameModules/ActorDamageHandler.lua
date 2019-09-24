local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ActorDamageHandler = PizzaAlpaca.GameModule:extend("ActorDamageHandler")

local eAttackActor = event:WaitForChild("eAttackActor")

function ActorDamageHandler:onRecs(recsCore)
    eAttackActor.OnServerEvent:connect(function(player, instance)
        assert(typeof(instance) == "Instance", "Invalid parameter")

        local ActorStats = recsCore:getComponent(instance, RecsComponents.ActorStats)
        local DamagedBy = recsCore:getComponent(instance, RecsComponents.DamagedBy)

        assert(ActorStats, "Invalid entity. Has no stats.")
        assert(DamagedBy, "Invalid entity. Has no DamagedBy component.")

        ActorStats:updateProperty("health", ActorStats.health - 1)
        DamagedBy:updateProperty("players", Dictionary.join({[player] = true}, DamagedBy.players))
    end)
end

function ActorDamageHandler:onStore(store)
    local recsContainer = self.core:getModule("ServerRECSContainer")
    recsContainer:getCore():andThen(function(recsCore)
        self:onRecs(recsCore)
    end)
end

function ActorDamageHandler:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return ActorDamageHandler