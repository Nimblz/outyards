local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)

local withScale = require(component.withScale)
local screenGuiWithScale = withScale("ScreenGui")

local function shadowFrame(anchor,size,pos)
    return Roact.createElement("Frame", {
        Active = true,
        BorderSizePixel = 0,
        BackgroundTransparency = 0.5,
        BackgroundColor3 = Color3.new(0,0,0),
    })
end

local function cutout(props)
    local size = props.Size
    local position = props.Position
    local anchorPoint = props.AnchorPoint

    local shadows = {}

    shadows.top = shadowFrame(Vector2.new(0,1), UDim2.new(1,0,1,2048), UDim2.new(0,0,0,0))
    shadows.bottom = shadowFrame(Vector2.new(0,0), UDim2.new(1,0,1,2048), UDim2.new(0,0,1,0))
    shadows.left = shadowFrame(Vector2.new(1, 0.5), UDim2.new(1,2048,2,2048), UDim2.new(0,0,0.5,0))
    shadows.right = shadowFrame(Vector2.new(0, 0.5), UDim2.new(1,2048,2,2048), UDim2.new(1,0,0.5,0))

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = size,
        Position = position,
        AnchorPoint = anchorPoint,
    }, shadows)
end

return function(props)
    local gui = Roact.createElement(screenGuiWithScale, {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 10,
    }, {
        cutout = cutout(props)
    })

    local portal = Roact.createElement(Roact.Portal, {
        target = PlayerGui
    }, {
        CutoutGui = gui
    })

    return portal
end