local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local components = script:FindFirstAncestor("uiComponents")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundFrame = require(components:WaitForChild("RoundFrame"))
local Crafting = Roact.Component:extend("Crafting")

local makeView = require(script.Parent:WaitForChild("makeView"))

function Crafting:init()
end

function Crafting:didMount()
end

function Crafting:render()
    local visible = self.props.visible

    return Roact.createElement(RoundFrame, {
        ImageTransparency = 0,
        Position = UDim2.new(0.5,0,0.5,0),
        Size = UDim2.new(0,600,0,400),
        AnchorPoint = Vector2.new(0.5,0.5),
        Visible = visible
    }, {
        Roact.createElement("TextLabel", {
            Text = "WIP LOL",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,1,0),
            TextSize = 64,
            BackgroundTransparency = 1,
        })
    })
end

Crafting = makeView(Crafting, "crafting")

return Crafting