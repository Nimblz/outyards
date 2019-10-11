-- keeps track of where the player wants to shoot
-- handles lock-on targeting for mobile

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local Targeting = PizzaAlpaca.GameModule:extend("Targeting")

function Targeting:preInit()
end

function Targeting:init()
end

function Targeting:postInit()
end

return Targeting