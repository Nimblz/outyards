-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Roact = require(lib:WaitForChild("Roact"))

local Dictionary = require(util:WaitForChild("Dictionary"))

local RoundButton = Roact.PureComponent:extend("RoundButton")

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
    local disabled = self.props.disabled or false
    local hovered = self.state.hovered or false
    local pressed = self.state.pressed or false

    local normalColor = props.color or props.ImageColor3 or props.BackgroundColor3 or Color3.new(1,1,1)
    local hoveredColor = props.hoveredColor or normalColor:lerp(Color3.fromRGB(0, 0, 0),0.1)
    local pressedColor = props.pressedColor or normalColor:lerp(Color3.fromRGB(0, 0, 0),0.25)
    local finalColor = (pressed and pressedColor) or (hovered and hoveredColor) or normalColor

    local inputFuncs = {
        mouseEnter = props[Roact.Event.MouseEnter],
        mouseLeave = props[Roact.Event.MouseLeave],
        mouseDown = props[Roact.Event.MouseButton1Down],
        mouseUp = props[Roact.Event.MouseButton1Up],
    }

    local function callInputFunc(name)
        if inputFuncs[name] and not disabled then
            inputFuncs[name]()
        end
    end

    local elementProps = Dictionary.join(props, {
        color = Dictionary.None,
        hoveredColor = Dictionary.None,
        pressedColor = Dictionary.None,
        disabled = Dictionary.None,

        ImageColor3 = finalColor,

        [Roact.Event.MouseEnter] = function()
            if disabled then return end
            self:setHovered(true)
            callInputFunc("mouseEnter")
        end,
        [Roact.Event.MouseLeave] = function()
            if disabled then return end
            self:setHovered(false)
            self:setPressed(false)
            callInputFunc("mouseLeave")
        end,
        [Roact.Event.MouseButton1Down] = function()
            if disabled then return end
            self:setPressed(true)
            callInputFunc("mouseDown")
        end,
        [Roact.Event.MouseButton1Up] = function()
            if disabled then return end
            self:setPressed(false)
            self:setHovered(false)
            callInputFunc("mouseUp")
        end,
    })

    return Roact.createElement("ImageButton", Dictionary.join({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://4103149690",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(16,16,16,16),
    }, elementProps))
end

return RoundButton