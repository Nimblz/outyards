local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))


local CmdrContainer = PizzaAlpaca.GameModule:extend("CmdrContainer")

function CmdrContainer:onStore(store)
    Cmdr.Registry:RegisterHook("BeforeRun", function(context)
        context.State.pzCore = self.core
        context.State.store = store
    end)

    Cmdr:SetActivationKeys({ Enum.KeyCode.RightAlt })
end

function CmdrContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")

    storeContainer:getStore():andThen(function(store)
        self:onStore(store)
    end)
end

return CmdrContainer