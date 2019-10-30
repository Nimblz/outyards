local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))

local FullScreenModal = Roact.Component:extend("FullScreenModal")

function FullScreenModal:init()
end

function FullScreenModal:didMount()
end

function FullScreenModal:render()
    local shadow = Roact.createElement("Frame", {
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,

        Size = UDim2.new(1,0,1,0),

        Active = true,
    }, self.props[Roact.Children])
    return Roact.createElement(Roact.Portal, {
        target = PlayerGui
    }, {
        modal = Roact.createElement("ScreenGui", {
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 10,
        }, {
            shadow = shadow
        })
    })
end

return FullScreenModal