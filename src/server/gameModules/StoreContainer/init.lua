-- contains the games store and handles action replication

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent.Parent
local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local middleware = script:WaitForChild("middleware")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Rodux = require(lib:WaitForChild("Rodux"))
local Signal = require(lib:WaitForChild("Signal"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Promise = require(lib:WaitForChild("Promise"))

local reducer = require(src:WaitForChild("serverReducer"))
local networkMiddleware = require(middleware:WaitForChild("networkMiddleware"))

local eReplicateAction = event:WaitForChild("eReplicateAction")

local StoreContainer = PizzaAlpaca.GameModule:extend("StoreContainer")

-- action replication handler
local function replicate(action, oldState, newState)
	-- Create a version of each action that's explicitly flagged as
	-- replicated so that clients can handle them explicitly.
	local replicatedAction = Dictionary.join(action, {
		replicated = true,
	})

	-- This is an action that everyone should see!
    if action.replicateBroadcast then
		return eReplicateAction:FireAllClients(replicatedAction)
	end

	-- This is an action that we want a specific player to see.
	if action.replicateTo ~= nil then
		local player = action.replicateTo
		return eReplicateAction:FireClient(player, replicatedAction)
	end

	return
end

function StoreContainer:create()
    self.storeCreated = Signal.new()
end

function StoreContainer:getStore()
    return Promise.async(function(resolve, reject)
        resolve(self.store or self.storeCreated:wait())
    end)
end

function StoreContainer:createStore(initialState)
    self.store = Rodux.Store.new(reducer,initialState, {
		Rodux.thunkMiddleware,
		--Rodux.loggerMiddleware,
        networkMiddleware(replicate),
    })
    self.storeCreated:fire()
    self.logger:log("Server store initialized.")
end

function StoreContainer:preInit()
end

function StoreContainer:init()
    self.logger = self.core:getModule("Logger"):createLogger(self)
    self:createStore()
end

function StoreContainer:postInit()
end

return StoreContainer