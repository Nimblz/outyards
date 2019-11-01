print("Starting outyards server.")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local server = script.Parent

local sidedModules = server:WaitForChild("gameModules")
local commonModules = common:WaitForChild("gameModules")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

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