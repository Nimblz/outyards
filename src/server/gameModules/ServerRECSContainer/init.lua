-- TODO: Genericize this module and replace with a common RECSContainer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local recsEvent = event:WaitForChild("recs")
local recsPlugins = common:WaitForChild("recsplugins")

local RECS = require(lib:WaitForChild("RECS"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Signal = require(lib:WaitForChild("Signal"))
local Promise = require(lib:WaitForChild("Promise"))

local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Systems = require(script.Systems)
local Steppers = require(script.Steppers)

local createInjectorPlugin = require(recsPlugins:WaitForChild("createInjectorPlugin"))
local createComponentPropsOverridePlugin = require(recsPlugins:WaitForChild("createComponentPropsOverridePlugin"))
local createBroadcasterPlugin = require(recsPlugins:WaitForChild("createComponentNetworkBroadcaster"))

local eComponentAdded = recsEvent:WaitForChild("eComponentAdded")
local eComponentRemoved = recsEvent:WaitForChild("eComponentRemoved")
local eComponentChanged = recsEvent:WaitForChild("eComponentChanged")
local eInitialComponents = recsEvent:WaitForChild("eInitialComponents")

local ServerRECSContainer = PizzaAlpaca.GameModule:extend("ServerRECSContainer")

function ServerRECSContainer:create()
    self.recsCoreCreated = Signal.new()
end

function ServerRECSContainer:onStoreCreated(store)
    self.recsCore = RECS.Core.new({
        RECS.BuiltInPlugins.CollectionService(),
        RECS.BuiltInPlugins.ComponentChangedEvent,
        createComponentPropsOverridePlugin(),
        createInjectorPlugin("getClientModule", function(_, name)
            return self.core:getModule(name)
        end),
        createInjectorPlugin("pzCore", self.core),
        createInjectorPlugin("store", store),
        createBroadcasterPlugin(
            eComponentAdded,
            eComponentChanged,
            eComponentRemoved,
            eInitialComponents
        )
    })

    -- register all components
    for _, component in pairs(RecsComponents) do
        self.recsCore:registerComponent(component)
    end

    self.recsCore:registerSystems(Systems)
    self.recsCore:registerSteppers(Steppers)
end

function ServerRECSContainer:getCore()
    return Promise.async(function(resolve, reject)
        resolve(self.recsCore or self.recsCoreCreated:wait())
    end)
end

function ServerRECSContainer:preInit()
end

function ServerRECSContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store)
        self:onStoreCreated(store)

        self.recsCore:start()
        self.recsCoreCreated:fire(self.recsCore)
    end)
end

function ServerRECSContainer:postInit()
end


return ServerRECSContainer