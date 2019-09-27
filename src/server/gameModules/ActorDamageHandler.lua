local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Selectors = require(common:WaitForChild("Selectors"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ActorDamageHandler = PizzaAlpaca.GameModule:extend("ActorDamageHandler")

local eAttackActor = event:WaitForChild("eAttackActor")

function ActorDamageHandler:onRecsAndStore(recsCore, store)
    eAttackActor.OnServerEvent:connect(function(player, instance)
        assert(typeof(instance) == "Instance", "Invalid parameter")

        local state = store:getState()

        local playerDamage = Selectors.getBaseDamage(state, player)
        assert(playerDamage, "Player damage is undefined!")

        local ActorStats = recsCore:getComponent(instance, RecsComponents.ActorStats)
        local DamagedBy = recsCore:getComponent(instance, RecsComponents.DamagedBy)


        assert(ActorStats, "Invalid entity. Has no stats.")
        assert(DamagedBy, "Invalid entity. Has no DamagedBy component.")

        DamagedBy:updateProperty("players", Dictionary.join({[player] = true}, DamagedBy.players))
        ActorStats:updateProperty("health", ActorStats.health - playerDamage)
    end)
end

function ActorDamageHandler:onStore(store)
    local recsContainer = self.core:getModule("ServerRECSContainer")
    recsContainer:getCore():andThen(function(recsCore)
        self:onRecsAndStore(recsCore, store)
    end)
end

function ActorDamageHandler:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return ActorDamageHandler