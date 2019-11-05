local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local Platform = PizzaAlpaca.GameModule:extend("Platform")

function Platform:create()
    self.usingController = GuiService:IsTenFootInterface()
end

function Platform:isUsingController()
    return self.usingController
end

function Platform:init()
    UserInputService.LastInputTypeChanged:connect(function(newType)
        self.usingController = newType == Enum.UserInputType.Gamepad1
    end)
end

return Platform