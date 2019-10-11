local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local SliceButton = Roact.Component:extend("SliceButton")

local UP_IMAGE = "rbxassetid://4047369323"
local DOWN_IMAGE = "rbxassetid://4047473656"
local SLICE_CENTER = Rect.new(32,32,64,64)

function SliceButton:init()
end

function SliceButton:didMount()
end

function SliceButton:render()
    local userProps = self.props
    local defaultProps = {
        Image = UP_IMAGE,
        PressedImage = DOWN_IMAGE,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = SLICE_CENTER,
        SliceScale = 0.75,
        BackgroundTransparency = 1,
    }
    return Roact.createElement("ImageButton", Dictionary.join(defaultProps,userProps))
end

return SliceButton