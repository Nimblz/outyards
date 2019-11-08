-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util

local Roact = require(lib.Roact)

local Dictionary = require(util.Dictionary)

return function(props)
    local elementProps = Dictionary.join(props, {
        BackgroundTransparency = Dictionary.None,
        BackgroundColor3 = Dictionary.None,
        BorderSizePixel = Dictionary.None,
        color = Dictionary.None,
        transparency = Dictionary.None,
    })

    elementProps.ImageColor3 = (
        props.color or
        props.ImageColor3 or
        props.BackgroundColor3 or
        Color3.new(1,1,1)
    )

    elementProps.ImageTransparency = (
        props.transparency or
        props.ImageTransparency or
        props.BackgroundTransparency or
        0
    )

    return Roact.createElement("ImageLabel", Dictionary.join({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://4103149690",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(16,16,16,16),
    }, elementProps))
end