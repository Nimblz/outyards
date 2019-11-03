local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local withScale = require(component:WaitForChild("withScale"))
local FullScreenModal = Roact.PureComponent:extend("FullScreenModal")

local screenGuiWithScale = withScale("ScreenGui")

function FullScreenModal:render()
    local transparency = self.props.transparency or 0
    local shadow = Roact.createElement("Frame", {
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = (0.5) + (0.5 * transparency),
        BorderSizePixel = 0,

        Size = UDim2.new(1,0,1,0),

        Active = true,
    }, self.props[Roact.Children])

    local modal = Roact.createElement(screenGuiWithScale, {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 10,
    }, {
        shadow = shadow,
    })

    local portal = Roact.createElement(Roact.Portal, {
        target = PlayerGui
    }, {
        modal = modal
    })

    return portal
end

return FullScreenModal