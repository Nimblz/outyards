local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))

local MenuButton = Roact.Component:extend("MenuButton")

function MenuButton:init()
end

function MenuButton:didMount()
end

function MenuButton:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0,100,0,100),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1,1,1),
    })
end

return MenuButton