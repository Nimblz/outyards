-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Roact = require(lib:WaitForChild("Roact"))

local Dictionary = require(util:WaitForChild("Dictionary"))

local RoundButton = Roact.Component:extend("RoundButton")

function RoundButton:init()
    self:setState(function(state)
        return {
            hovered = false
        }
    end)
end

function RoundButton:setHovered(bool)
    self:setState(function(state)
        return {
            hovered = bool
        }
    end)
end

function RoundButton:setPressed(bool)
    self:setState(function(state)
        return {
            pressed = bool
        }
    end)
end

function RoundButton:render()
    local props = self.props
    local hovered = self.state.hovered or false
    local pressed = self.state.pressed or false

    local normalColor = Color3.new(1,1,1)
    local hoveredColor = Color3.new(0.9,0.9,0.9)
    local pressedColor = Color3.new(0.8,0.8,0.8)

    local elementProps = Dictionary.join(props, {
        color = Dictionary.None,
    })

    props.color = (pressed and pressedColor) or (hovered and hoveredColor) or normalColor

    elementProps.ImageColor3 = (
        props.color or
        props.ImageColor3 or
        props.BackgroundColor3 or
        Color3.new(1,1,1)
    )

    return Roact.createElement("ImageButton", Dictionary.join({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://4103149690",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(16,16,16,16),
        [Roact.Event.MouseEnter] = function() self:setHovered(true) end,
        [Roact.Event.MouseLeave] = function() self:setHovered(false) self:setPressed(false) end,
        [Roact.Event.MouseButton1Down] = function() self:setPressed(true) end,
        [Roact.Event.MouseButton1Up] = function() self:setPressed(false) end,
    }, elementProps))
end

return RoundButton