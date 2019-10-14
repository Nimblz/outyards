-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Roact = require(lib:WaitForChild("Roact"))

local Dictionary = require(util:WaitForChild("Dictionary"))

return function(props)
    local elementProps = Dictionary.join(props, {
        color = Dictionary.None,
    })

    elementProps.ImageColor3 = (
        props.color or
        props.ImageColor3 or
        props.BackgroundColor3 or
        Color3.new(1,1,1)
    )

    return Roact.createElement("ImageLabel", Dictionary.join({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://4103149690",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(16,16,16,16),
    }, elementProps))
end