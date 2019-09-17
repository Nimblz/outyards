print("Starting outyards client.")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = script.Parent

local sidedModules = client:WaitForChild("gameModules")
local commonModules = common:WaitForChild("gameModules")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

-- create PizzaAlpaca core instance
local clientCore = PizzaAlpaca.GameCore.new()
clientCore._debugPrints = true

-- load sided and common modules
clientCore:registerChildrenAsModules(commonModules)
clientCore:registerChildrenAsModules(sidedModules)

-- start the core
clientCore:load()

print("Loading complete! Thanks for playing outyards!~")