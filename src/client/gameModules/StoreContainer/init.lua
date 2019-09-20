-- contains the games store and handles action replication

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent.Parent
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Rodux = require(lib:WaitForChild("Rodux"))
local Signal = require(lib:WaitForChild("Signal"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Promise = require(lib:WaitForChild("Promise"))

local reducer = require(src:WaitForChild("clientReducer"))

local eReplicateAction = event:WaitForChild("eReplicateAction")
local eInitialState = event:WaitForChild("eInitialState")

local StoreContainer = PizzaAlpaca.GameModule:extend("StoreContainer")

function StoreContainer:create()
    self.storeCreated = Signal.new()
end

function StoreContainer:getStore()
    return Promise.async(function(resolve, reject)
        resolve(self.store or self.storeCreated:wait())
    end)
end

function StoreContainer:createStore(initialState)
    local store = Rodux.Store.new(reducer,initialState, {
		Rodux.thunkMiddleware,
		Rodux.loggerMiddleware,
    })

    eReplicateAction.OnClientEvent:connect(function(replicatedAction)
        store:dispatch(replicatedAction)
    end)

    self.store = store

    self.storeCreated:fire()
    self.logger:log("Client store initialized.")
end

function StoreContainer:preInit()
end

function StoreContainer:init()
    self.logger = self.core:getModule("Logger"):createLogger(self)

    local initalStateConnection
    initalStateConnection = eInitialState.OnClientEvent:connect(function(initialState)
        initalStateConnection:disconnect()
        self:createStore(initialState)
    end)
end

function StoreContainer:postInit()
end

return StoreContainer