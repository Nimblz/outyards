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

        local actorStats = recsCore:getComponent(instance, RecsComponents.ActorStats)
        local damagedBy = recsCore:getComponent(instance, RecsComponents.DamagedBy)

        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        if humanoid.Health <= 0 then return end
        local root = char.PrimaryPart
        if not root then return end
        local rootPos = root.Position
        local mobPos = instance.Position
        local knockbackDirection = (mobPos-rootPos) * Vector3.new(1,0,1)
        knockbackDirection = knockbackDirection.Unit


        if not actorStats then return end
        if not damagedBy then return end

        damagedBy:updateProperty("players", Dictionary.join({[player.Name] = true}, damagedBy.players))
        actorStats:updateProperty("health", actorStats.health - playerDamage)

        instance.Velocity = instance.Velocity + Vector3.new(0,30,0)
        instance.Velocity = instance.Velocity + knockbackDirection * 50
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