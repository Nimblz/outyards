local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent.Parent
local lib = ReplicatedStorage:WaitForChild("lib")

local Rodux = require(lib:WaitForChild("Rodux"))
local Signal = require(lib:WaitForChild("Signal"))

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local reducer = require(src:WaitForChild("serverReducer"))

local StoreContainer = PizzaAlpaca.GameModule:extend("StoreContainer")

function StoreContainer:create()
    self.storeCreated = Signal.new()
end

function StoreContainer:getStore()
    return self.store
end

function StoreContainer:createStore(initialState)
    self.logger:log("Server store initialized.")
    self.store = Rodux.Store.new(reducer,initialState, {
        Rodux.thunkMiddleware,
    })
    self.storeCreated:fire()
end

function StoreContainer:preInit()
end

function StoreContainer:init()
    self.logger = self.core:getModule("Logger"):createLogger(self)
end

function StoreContainer:postInit()
end

return StoreContainer