local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local cmdrModule = ReplicatedStorage:WaitForChild("CmdrClient")
cmdrModule:WaitForChild("Commands")

local PizzaAlpaca = require(lib.PizzaAlpaca)
local Cmdr = require(cmdrModule)


local CmdrContainer = PizzaAlpaca.GameModule:extend("CmdrContainer")

function CmdrContainer:onStore(store)
    self.logger:log("Starting Cmdr...")

    self.logger:log("Registering Hooks...")
    Cmdr.Registry:RegisterHook("BeforeRun", function(context)
        context.State.pzCore = self.core
        context.State.store = store
    end)

    self.logger:log("Setting activation keys...")
    Cmdr:SetActivationKeys({ Enum.KeyCode.RightAlt })

    self.logger:log("Cmdr Started!")
end

function CmdrContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")
    self.logger = self.core:getModule("Logger"):createLogger(self)

    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)
end

return CmdrContainer