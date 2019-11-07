-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")

local src = script:FindFirstAncestor("server")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")

local Items = require(common:WaitForChild("Items"))
local Actions = require(common:WaitForChild("Actions"))

local AI = require(src.ai:WaitForChild("AI"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
local ParticleCreator = require(common:WaitForChild("ParticleCreator"))

local errors = {
    invalidItemId = "Invalid drop item id [%s]!"
}

local AISystem = RECS.System:extend("AISystem")

local function randomRange(min,max)
    local diff = max-min
    return min + (math.random()*diff)
end

function AISystem:onComponentAdded(instance,aiComponent)
    local newAI = AI.new(instance,self.core,self.pzCore, aiComponent.aiType)
    self.AIs[aiComponent] = newAI

    local actorStats = self.core:getComponent(instance,RecsComponents.ActorStats)
    local changedConnection

    newAI.enteringState:connect(function(newState, stateDesc)
        aiComponent:updateProperty("aiState", {state = newState})
        aiComponent:updateProperty("animationState", {state = stateDesc.animationOverride or newState})
    end)

    changedConnection = actorStats.changed:connect(function(key,new,old)
        if key == "health" then
            if new <= 0 then
                changedConnection:disconnect()

                CollectionService:RemoveTag(instance, "ActorStats")

                local dropsComponent = self.core:getComponent(instance,RecsComponents.ItemDrops)
                local damagedByComponent = self.core:getComponent(instance,RecsComponents.DamagedBy)
                if dropsComponent then
                    for _,dropDescription in pairs(dropsComponent.items) do
                        -- {itemId = "matWood", dropRange = {min = 4, max = 10}, dropRate = 1.00}

                        local itemId = dropDescription.itemId
                        local dropRange = dropDescription.dropRange
                        local dropRate = dropDescription.dropRate

                        assert(Items.byId[itemId], errors.invalidItemId:format(itemId))

                        local dropAmmt = math.floor(randomRange(dropRange.min,dropRange.max)+0.5)

                        if math.random() <= dropRate then
                            -- award the drop to everyone in this npcs damagedby component
                            for playerName,_ in pairs(damagedByComponent.players) do
                                local player = game:GetService("Players"):FindFirstChild(playerName)
                                if player then
                                    self.store:dispatch(Actions.ITEM_ADD(player,itemId,dropAmmt))
                                end
                            end
                        end
                    end
                    for playerName,_ in pairs(damagedByComponent.players) do
                        local player = game:GetService("Players"):FindFirstChild(playerName)
                        if player then
                            self.store:dispatch(Actions.CASH_ADD(player, dropsComponent.cash or 0))
                        end
                    end
                end

                if not instance.Anchored then
                    instance:SetNetworkOwner(nil)
                end

                self.AIs[aiComponent]:kill()
                self.AIs[aiComponent] = nil

                ParticleCreator.spawnParticle("smoke", {
                    cFrame = instance.CFrame,
                    scale = 1,
                    amount = 3
                })

                instance:Destroy()
            end
        end
    end)
end

function AISystem:onComponentRemoving(instance,component)
end

function AISystem:init()
    self.AIs = {}

    for instance,component in self.core:components(RecsComponents.AI) do
        self:onComponentAdded(instance, component)
    end
    -- on component add create a bodyvelocity bodyforce and bodygyro
    self.core:getComponentAddedSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentAdded(instance,component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentRemoving(instance,component)
    end)
end

function AISystem:step()
    for _,ai in pairs(self.AIs) do
        coroutine.wrap(function()
            ai:step()
        end)()
    end
end

return AISystem