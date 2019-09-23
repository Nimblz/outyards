local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local PrototypeInventory = Roact.Component:extend("PrototypeInventory")

function PrototypeInventory:init()
end

function PrototypeInventory:didMount()
end

function PrototypeInventory:render()
    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(0,300,0,600),
        AnchorPoint = Vector2.new(1,0.5),
        Position = UDim2.new(1,0,0.5,0),

        BorderSizePixel = 0,
        BackgroundTransparency = 0.75,
        BackgroundColor3 = Color3.new(1,1,1),

        ScrollBarThickness = 16,
        TopImage = "rbxassetid://1539341292",
        MidImage = "rbxassetid://1539341292",
        BottomImage = "rbxassetid://1539341292",
        CanvasSize = UDim2.new(0,0,2,0),
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    })
end

return PrototypeInventory