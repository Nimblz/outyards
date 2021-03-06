local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local PizzaAlpaca = require(lib.PizzaAlpaca)

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