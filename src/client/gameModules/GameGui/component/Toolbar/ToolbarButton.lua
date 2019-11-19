local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)

local ToolbarButton = Roact.PureComponent:extend("ToolbarButton")

local PADDING = 16

function ToolbarButton:init()
end

function ToolbarButton:didMount()
end

function ToolbarButton:render()
    return Roact.createElement("Frame", {
        Size = UDim2.fromOffset(48+PADDING*2,48+PADDING*2),
        BackgroundColor3 = Color3.new(1,1,1),
    })
end

return ToolbarButton