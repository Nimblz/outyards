-- frame with rounded corners
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Dictionary = require(util.Dictionary)

local RoundFrame = require(component.RoundFrame)

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
    local backgroundKind = props.backgroundKind or RoundFrame
    local disabled = props.disabled or false

    local hovered = self.state.hovered or false
    local pressed = self.state.pressed or false
    local autoColor = self.state.autoColor == true

    local normalColor = props.color or props.ImageColor3 or props.BackgroundColor3 or Color3.new(1,1,1)
    local hoveredColor = props.hoveredColor or normalColor:lerp(Color3.fromRGB(0, 0, 0),0.1)
    local pressedColor = props.pressedColor or normalColor:lerp(Color3.fromRGB(0, 0, 0),0.25)
    local finalColor = normalColor

    if autoColor then
        finalColor = (pressed and pressedColor) or (hovered and hoveredColor) or normalColor
    end

    local inputFuncs = {
        mouseEnter = props[Roact.Event.MouseEnter],
        mouseLeave = props[Roact.Event.MouseLeave],
        mouseDown = props[Roact.Event.MouseButton1Down],
        mouseUp = props[Roact.Event.MouseButton1Up],
        activated = props[Roact.Event.Activated],
    }

    local function callInputFunc(name)
        if inputFuncs[name] and not disabled then
            inputFuncs[name]()
        end
    end

    local elementProps = {
        Size = self.props.Size,
        Position = self.props.Position,
        AnchorPoint = self.props.AnchorPoint,
        BackgroundTransparency = 1,

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
        [Roact.Event.Activated] = function()
            callInputFunc("activated")
        end,
    }

    local joinedChildren = Dictionary.join({
        ["$BACKGROUND"] = Roact.createElement(backgroundKind, {
            color = finalColor,
            Size = UDim2.fromScale(1,1),
            ZIndex = 1,
        }),
        ["$CHILDREN"] = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1,1),
            ZIndex = 2
        }, self.props[Roact.Children]),
    }, self.props.decorators)

    return Roact.createElement("ImageButton", Dictionary.join({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "",
        ImageTransparency = 1,
    }, elementProps), joinedChildren)
end

return RoundButton