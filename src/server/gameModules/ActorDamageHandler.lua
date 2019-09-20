local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local RecsComponents = require(common:WaitForChild("RecsComponents"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ActorDamageHandler = PizzaAlpaca.GameModule:extend("ActorDamageHandler")

local eAttackActor = event:WaitForChild("eAttackActor")

function ActorDamageHandler:onStore(store)
    self.recsCore = self.recsContainer.recsCore
    eAttackActor.OnServerEvent:connect(function(player, instance)
        assert(typeof(instance) == "Instance", "Invalid parameter")

        local ActorStats = self.recsCore:getComponent(instance, RecsComponents.ActorStats)

        assert(ActorStats, "Invalid entity. Has no stats.")

        ActorStats:updateProperty("health", ActorStats.health - 1)
    end)
end

function ActorDamageHandler:preInit()
    self.recsContainer = self.core:getModule("ServerRECSContainer")
    self.storeContainer = self.core:getModule("StoreContainer")
end

function ActorDamageHandler:init()
    self.storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

function ActorDamageHandler:postInit()
end

return ActorDamageHandler