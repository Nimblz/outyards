print("Starting outyards server.")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local server = script.Parent

local sidedModules = server.gameModules
local commonModules = common.gameModules

local PizzaAlpaca = require(lib.PizzaAlpaca)

-- create PizzaAlpaca core instance
local core = PizzaAlpaca.GameCore.new()
core._debugPrints = true

-- load sided and common modules
core:registerChildrenAsModules(commonModules)
core:registerChildrenAsModules(sidedModules)

-- start the core
core:load()

print("Outyards server started!")

_G.core = core

core:getModule("StoreContainer"):getStore():andThen(function(store)
    _G.store = store
end)