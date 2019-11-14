local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)
local Otter = require(lib.Otter)

local RoundButton = require(component.RoundButton)
local FancyButton = Roact.Component:extend("FancyButton")

function FancyButton:init()
    self.motor = Otter.createSingleMotor(1)
    self:setScale(1)

    self.motor:onStep(function(scale)
        self:setScale(scale)
    end)
end

function FancyButton:setScale(scale)
    self:setState(function()
        return {
            scale = scale
        }
    end)
end

function FancyButton:setGoal(goalScale)
    self.motor:setGoal(Otter.spring(goalScale,{
        frequency = self.props.frequency or 5,
        dampingRatio = self.props.dampingRatio or 1
    }))
end

function FancyButton:didMount()
end

function FancyButton:render()
    local disabled = self.props.disabled

    local function hovered()
        self:setGoal(1.1)
    end

    local function unhovered()
        self:setGoal(1)
    end

    local function mouseDown()
        self:setGoal(0.95)
    end

    local function mouseUp()
        self:setGoal(1)
    end

    local mergedProps = Dictionary.join(self.props, {
        Size = UDim2.new(1,0,1,0),
        Position = UDim2.new(0.5,0,0.5,0),
        AnchorPoint = Vector2.new(0.5,0.5),

        color = disabled and Color3.fromRGB(180, 180, 180) or self.props.color,

        decorators = {
            scale = Roact.createElement("UIScale", {
                Scale = self.state.scale,
            })
        },

        [Roact.Children] = Dictionary.None,

        [Roact.Event.MouseEnter] = function(...)
            if disabled then return end
            hovered()
            if self.props[Roact.Event.MouseEnter] then
                self.props[Roact.Event.MouseEnter](...)
            end
        end,
        [Roact.Event.MouseLeave] = function(...)
            if disabled then return end
            unhovered()
            if self.props[Roact.Event.MouseLeave] then
                self.props[Roact.Event.MouseLeave](...)
            end
        end,
        [Roact.Event.MouseButton1Down] = function(...)
            if disabled then return end
            mouseDown()
            if self.props[Roact.Event.MouseButton1Down] then
                self.props[Roact.Event.MouseButton1Down](...)
            end
        end,
        [Roact.Event.MouseButton1Up] = function(...)
            if disabled then return end
            mouseUp()
            if self.props[Roact.Event.MouseButton1Up] then
                self.props[Roact.Event.MouseButton1Up](...)
            end
        end,
        [Roact.Event.Activated] = function(...)
            if not disabled then
                if self.props[Roact.Event.Activated] then
                    self.props[Roact.Event.Activated](...)
                end
            end
        end
    })

    local frameProps = {
        Size = self.props.Size,
        Position = self.props.Position,
        AnchorPoint = self.props.AnchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = self.props.LayoutOrder
    }

    return Roact.createElement("Frame", frameProps, {
        button = Roact.createElement(RoundButton, mergedProps, self.props[Roact.Children]),
    })
end

return FancyButton