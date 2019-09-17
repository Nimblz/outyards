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

local RecsContainer = PizzaAlpaca.GameModule:extend("RecsContainer")

function RecsContainer:preInit()
end

function RecsContainer:init()
    self.recsCore = RECS.Core.new({
        RECS.BuiltInPlugins.CollectionService(),
        RECS.BuiltInPlugins.ComponentChangedEvent,
        createInjectorPlugin("getClientModule", function(_, name)
            return self.core:getModule(name)
        end),
    })

    -- register all components
    for _, component in pairs(RecsComponents) do
        self.recsCore:registerComponent(component)
    end

    self.recsCore:registerSystems(Systems)
    self.recsCore:registerSteppers(Steppers)

    self.recsCore:start()
end

function RecsContainer:postInit()
end


return RecsContainer