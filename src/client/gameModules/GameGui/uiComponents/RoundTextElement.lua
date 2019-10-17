-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))
local Dictionary = require(util:WaitForChild("Dictionary"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local RoundButton = require(component:WaitForChild("RoundButton"))

return function(props)
    local kind = props.kind or "TextLabel"
    local isButton = kind:sub((#kind)-(#"Button")+1) == "Button"
    local roundKind = isButton and RoundButton or RoundFrame

    -- make props without component properties
    local elementProps = Dictionary.join(props, {
        kind = Dictionary.None,
        color = Dictionary.None,
        transparency = Dictionary.None,

        [Roact.Children] = Dictionary.None,
    })

    -- make props without any text properties
    local roundFrameProps = Dictionary.join(elementProps, {
        Font = Dictionary.None,
        LineHeight = Dictionary.None,
        LocalizedText = Dictionary.None,
        Text = Dictionary.None,
        TextBounds = Dictionary.None,
        TextColor3 = Dictionary.None,
        TextFits = Dictionary.None,
        TextScaled = Dictionary.None,
        TextSize = Dictionary.None,
        TextStrokeColor3 = Dictionary.None,
        TextStrokeTransparency = Dictionary.None,
        TextTransparency = Dictionary.None,
        TextTruncate = Dictionary.None,
        TextWrapped = Dictionary.None,
        TextXAlignment = Dictionary.None,
        TextYAlignment = Dictionary.None,

        color = props.color,
        transparency = props.transparency,
    })

    -- make props without any image properties
    local textProps = Dictionary.join(elementProps, {
        Image = Dictionary.None,
        ImageColor3 = Dictionary.None,
        ImageRectOffset = Dictionary.None,
        ImageRectSize = Dictionary.None,
        ImageTransparency = Dictionary.None,
        IsLoaded = Dictionary.None,
        ScaleType = Dictionary.None,
        SliceCenter = Dictionary.None,
        SliceScale = Dictionary.None,
        TileSize = Dictionary.None,

        AnchorPoint = Vector2.new(0,0),
        Size = UDim2.new(1,0,1,0),
        Position = UDim2.new(0,0,0,0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    })

    return Roact.createElement(roundKind, roundFrameProps, {
        Roact.createElement(kind, textProps, props[Roact.Children])
    })
end