local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)

local SpriteLabel = require(component.SpriteLabel)

local SpriteDisplay = Roact.PureComponent:extend("SpriteDisplay")

function SpriteDisplay:init()
end

function SpriteDisplay:didMount()
end

function SpriteDisplay:render()
    local props = self.props
    local frameProps = props.frameProps or {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1,1,1),
        Size = UDim2.new(1,0,0,80),
        ClipsDescendants = true,
    }
    local spriteProps = props.spriteProps

    local gamut = Roact.createElement("ImageLabel", {
        Size = UDim2.fromOffset(256,256),
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        BackgroundTransparency = 1,
        ZIndex = 1,

        Image = "rbxassetid://2637691015",
        ImageColor3 = Color3.fromRGB(222,222,222),
        ScaleType = Enum.ScaleType.Tile,
        TileSize = UDim2.fromOffset(32,32)
    })

    local vignette = Roact.createElement("ImageLabel", {
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        ZIndex = 2,

        Image = "rbxassetid://260155349",
    })

    local sprite = Roact.createElement(SpriteLabel, Dictionary.join({
        Position = UDim2.fromScale(0.5,0.5),
        AnchorPoint = Vector2.new(0.5,0.5),
        ZIndex = 3,
    }, spriteProps))

    return Roact.createElement("Frame", frameProps, {
        vignette = vignette,
        sprite = sprite,
        gamut = gamut,
    })
end

return SpriteDisplay