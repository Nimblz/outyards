-- TODO: Genericize this module and replace with a common RECSContainer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local recsPlugins = common:WaitForChild("recsplugins")

local RECS = require(lib:WaitForChild("RECS"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Systems = require(script.Systems)
local Steppers = require(script.Steppers)

local createInjectorPlugin = require(recsPlugins:WaitForChild("createInjectorPlugin"))
local createComponentPropsOverridePlugin = require(recsPlugins:WaitForChild("createComponentPropsOverridePlugin"))

local ServerRECSContainer = PizzaAlpaca.GameModule:extend("ServerRECSContainer")

function ServerRECSContainer:preInit()
    self.recsCore = RECS.Core.new({
        RECS.BuiltInPlugins.CollectionService(),
        RECS.BuiltInPlugins.ComponentChangedEvent,
        createComponentPropsOverridePlugin(),
        createInjectorPlugin("getClientModule", function(_, name)
            return self.core:getModule(name)
        end),
        createInjectorPlugin("pzCore", self.core)
    })

    -- register all components
    for _, component in pairs(RecsComponents) do
        self.recsCore:registerComponent(component)
    end

    self.recsCore:registerSystems(Systems)
    self.recsCore:registerSteppers(Steppers)
end

function ServerRECSContainer:init()
    self.recsCore:start()
end

function ServerRECSContainer:postInit()
end


return ServerRECSContainer