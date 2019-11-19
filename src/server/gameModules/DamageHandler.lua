local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local util = common.util

local Dictionary = require(util.Dictionary)
local RecsComponents = require(common.RecsComponents)
local Selectors = require(common.Selectors)
local PizzaAlpaca = require(lib.PizzaAlpaca)

local DamageHandler = PizzaAlpaca.GameModule:extend("DamageHandler")

local eAttackActor = event.eAttackActor

function DamageHandler:onRecsAndStore(recsCore, store)
    eAttackActor.OnServerEvent:connect(function(player, instance)
        assert(typeof(instance) == "Instance", "Invalid parameter")

        local state = store:getState()

        local playerDamage = Selectors.getBaseDamage(state, player)
        assert(playerDamage, "Player damage is undefined!")

        playerDamage = math.max(playerDamage + playerDamage*(math.random()*0.1 - 0.05),1)

        local actorStats = recsCore:getComponent(instance, RecsComponents.ActorStats)
        local damagedBy = recsCore:getComponent(instance, RecsComponents.DamagedBy)

        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        if humanoid.Health <= 0 then return end
        local root = char.PrimaryPart
        if not root then return end
        local knockbackDirection = root.CFrame.LookVector * Vector3.new(1,0,1)
        knockbackDirection = knockbackDirection.Unit


        if not actorStats then return end
        if not damagedBy then return end

        if actorStats.friendly then return end

        local previousDamage = damagedBy.players[player.Name] or 0

        damagedBy:updateProperty("players",
            Dictionary.join(
                damagedBy.players,
                {[player.Name] = previousDamage + playerDamage}
            )
        )

        actorStats:updateProperty("health", actorStats.health - playerDamage)

        if not self.knockingBack[instance] and actorStats.canKnockback then
            self.knockingBack[instance] = true

            local driver = recsCore:getComponent(instance, RecsComponents.NPCDriver)

            if driver then driver:updateProperty("knockbacking", true) end

            instance.Velocity = Vector3.new(0,30,0)
            instance.Velocity = instance.Velocity + knockbackDirection * 30 * actorStats.knockbackMultiplier
            delay(1/4, function()
                if driver then driver:updateProperty("knockbacking", false) end
                self.knockingBack[instance] = false
            end)
        end
    end)
end

function DamageHandler:onStore(store)
    local recsContainer = self.core:getModule("ServerRECSContainer")
    recsContainer:getCore():andThen(function(recsCore)
        self:onRecsAndStore(recsCore, store)
    end)
end

function DamageHandler:init()
    self.knockingBack = {}
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store) self:onStore(store) end)
end

return DamageHandler