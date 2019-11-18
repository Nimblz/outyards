-- TODO: Genericize this module and replace with a common RECSContainer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local func = ReplicatedStorage.func
local recsEvent = event.recs
local recsPlugins = common.recsplugins

local RECS = require(lib.RECS)
local PizzaAlpaca = require(lib.PizzaAlpaca)
local Signal = require(lib.Signal)
local Promise = require(lib.Promise)

local RecsComponents = require(common.RecsComponents)
local Systems = require(script.Systems)
local Steppers = require(script.Steppers)

local createInjectorPlugin = require(recsPlugins.createInjectorPlugin)
local createComponentPropsOverridePlugin = require(recsPlugins.createComponentPropsOverridePlugin)
local createSubscriberPlugin = require(recsPlugins.createComponentNetworkSubscriber)

local eComponentAdded = recsEvent.eComponentAdded
local eComponentRemoved = recsEvent.eComponentRemoved
local eComponentChanged = recsEvent.eComponentChanged
local fGetEntities = func.fGetEntities

local ClientRECSContainer = PizzaAlpaca.GameModule:extend("ClientRECSContainer")

function ClientRECSContainer:create()
    self.recsCoreCreated = Signal.new()
end

function ClientRECSContainer:onStoreCreated(store)
    self.recsCore = RECS.Core.new({
        --RECS.BuiltInPlugins.CollectionService(),
        RECS.BuiltInPlugins.ComponentChangedEvent,
        createComponentPropsOverridePlugin(),
        createInjectorPlugin("getClientModule", function(_, name)
            return self.core:getModule(name)
        end),
        createInjectorPlugin("pzCore", self.core),
        createInjectorPlugin("store", store),
        createSubscriberPlugin(
            eComponentAdded,
            eComponentChanged,
            eComponentRemoved,
            fGetEntities
        )
    })

    -- register all components
    for _, component in pairs(RecsComponents) do
        self.recsCore:registerComponent(component)
    end

    self.recsCore:registerSystems(Systems)
    self.recsCore:registerSteppers(Steppers)
end

function ClientRECSContainer:getCore()
    return Promise.async(function(resolve, reject)
        resolve(self.recsCore or self.recsCoreCreated:wait())
    end)
end

function ClientRECSContainer:preInit()
end

function ClientRECSContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store)
        return Promise.async(function(resolve)
                self:onStoreCreated(store)

                self.recsCore:start()
                self.recsCoreCreated:fire(self.recsCore)
            resolve()
        end)
    end)
end

function ClientRECSContainer:postInit()
end


return ClientRECSContainer