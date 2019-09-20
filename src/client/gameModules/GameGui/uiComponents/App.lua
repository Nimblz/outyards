local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local uiComponents = script.Parent

local Roact = require(lib:WaitForChild("Roact"))

local App = Roact.Component:extend("App")
--local CoinCounter = require(uiComponents:WaitForChild("CoinCounter"))
local CodeLabLogo = require(uiComponents:WaitForChild("CodeLabLogo"))

function App:init()
end

function App:didMount()
end

function App:render()

    local elements = {
        --coinCointer = Roact.createElement(CoinCounter),
        logo = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0,1),
            Position = UDim2.new(0,8,1,-8),
            Size = UDim2.new(0,256,0,256),
            BackgroundTransparency = 1,
        }, {
            logo = Roact.createElement(CodeLabLogo),
            scaler = Roact.createElement("UIScale", {
                Scale = 64/256,
            })
        }),
    }

    return Roact.createElement("ScreenGui",{
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, elements)
end

return App