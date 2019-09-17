local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local InputHandler = PizzaAlpaca.GameModule:extend("InputHandler")

function InputHandler:preInit()

end

function InputHandler:init()

end

function InputHandler:postInit()

end

return InputHandler