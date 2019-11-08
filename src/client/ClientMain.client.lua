print("Starting outyards client.")

if not game:IsLoaded() then game.Loaded:Wait() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local event = ReplicatedStorage.event
local client = script.Parent

local eClientReady = event.eClientReady

local sidedModules = client.gameModules
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

eClientReady:FireServer()

print("Loading complete! Thanks for playing outyards!~")