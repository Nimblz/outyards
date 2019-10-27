print("Starting outyards client.")

if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local client = script.Parent

local sidedModules = client:WaitForChild("gameModules")
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

print("Loading complete! Thanks for playing outyards!~")