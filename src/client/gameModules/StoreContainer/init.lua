-- contains the games store and handles action replication

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent.Parent
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Rodux = require(lib.Rodux)
local Signal = require(lib.Signal)
local PizzaAlpaca = require(lib.PizzaAlpaca)
local Promise = require(lib.Promise)

local reducer = require(src.clientReducer)

local eReplicateAction = event.eReplicateAction
local eInitialState = event.eInitialState

local StoreContainer = PizzaAlpaca.GameModule:extend("StoreContainer")

function StoreContainer:create()
    self.storeCreated = Signal.new()
end

function StoreContainer:getStore()
    return Promise.async(function(resolve, reject)
        if not self.store then
            self.storeCreated:wait()
        end
        resolve(self.store)
    end)
end

function StoreContainer:createStore(initialState)
    local store = Rodux.Store.new(reducer,initialState, {
		Rodux.thunkMiddleware,
		--Rodux.loggerMiddleware,
    })

    eReplicateAction.OnClientEvent:connect(function(replicatedAction)
        store:dispatch(replicatedAction)
    end)

    self.store = store

    self.storeCreated:fire(store)
    self.logger:log("Client store initialized.")
end

function StoreContainer:preInit()
    self.logger = self.core:getModule("Logger"):createLogger(self)

    local initalStateConnection
    initalStateConnection = eInitialState.OnClientEvent:connect(function(initialState)
        initalStateConnection:disconnect()
        self:createStore(initialState)
    end)
end

function StoreContainer:init()
end

function StoreContainer:postInit()
end

return StoreContainer