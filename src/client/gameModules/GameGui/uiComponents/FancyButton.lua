local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("uiComponent")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local RoundButton = require(component:WaitForChild("RoundButton"))
local FancyButton = Roact.Component:extend("FancyButton")

function FancyButton:init()
    self:setScale(1)
end

function FancyButton:setScale(scale)
    self:setState(function()
        return {
            scale = scale
        }
    end)
end

function FancyButton:didMount()
end

function FancyButton:render()

    local function hovered()
        self:setScale(1.1)
    end

    local function unhovered()
        self:setScale(1)
    end

    local function mouseDown()
        self:setScale(0.9)
    end

    local function mouseUp()
        self:setScale(1)
    end

    local mergedProps = Dictionary.join(self.props, {
        [Roact.Event.MouseEnter] = function(...)
            hovered()
            if self.props[Roact.Event.MouseEnter] then
                self.props[Roact.Event.MouseEnter](...)
            end
        end,
        [Roact.Event.MouseLeave] = function(...)
            unhovered()
            if self.props[Roact.Event.MouseLeave] then
                self.props[Roact.Event.MouseLeave](...)
            end
        end,
        [Roact.Event.MouseButton1Down] = function(...)
            mouseDown()
            if self.props[Roact.Event.MouseButton1Down] then
                self.props[Roact.Event.MouseButton1Down](...)
            end
        end,
        [Roact.Event.MouseButton1Up] = function(...)
            mouseUp()
            if self.props[Roact.Event.MouseButton1Up] then
                self.props[Roact.Event.MouseButton1Up](...)
            end
        end
    })

    return Roact.createElement("Frame", frameProps, {
        button = Roact.createElement(RoundButton, mergedProps, self.props[Roact.Children])
    })
end

return FancyButton