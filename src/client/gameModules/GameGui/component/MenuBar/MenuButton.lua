local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("component")

local Roact = require(lib:WaitForChild("Roact"))

local FancyButton = require(component:WaitForChild("FancyButton"))
local RoundFrame = require(component:WaitForChild("RoundFrame"))
local MenuButton = Roact.Component:extend("MenuButton")

local function noop() end

function MenuButton:init()
    self:setHovered(false)
end

function MenuButton:setHovered(bool)
    self:setState(function(state)
        return {
            hovered = bool
        }
    end)
end

function MenuButton:render()
    local name = self.props.name or "N/A"
    local active = self.props.active or false
    local callback = self.props.callback or noop

    local hovered = self.state.hovered or false

    return Roact.createElement(FancyButton, {
        [Roact.Ref] = self.props.buttonRef,

        NextSelectionDown = self.props.downRef,
        NextSelectionUp = self.props.upRef,

        Size = UDim2.new(0,72,0,72),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1,1,1),
        LayoutOrder = self.props.layoutOrder,
        [Roact.Event.MouseEnter] = function()
            self:setHovered(true)
        end,
        [Roact.Event.MouseLeave] = function()
            self:setHovered(false)
        end,
        [Roact.Event.Activated] = function()
            callback()
        end
    }, {
        icon = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            BackgroundTransparency = 1,
            Image = self.props.icon,
            ImageColor3 = Color3.new(0,0,0),
            Size = UDim2.new(0,48,0,48),
        }),
        name = (hovered or active) and Roact.createElement(RoundFrame, {
            AnchorPoint = Vector2.new(0,0.5),
            Position = UDim2.new(1,16,0.5,0),
            Size = UDim2.new(0,128,0,32),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255,255,255),
        }, {
            text = Roact.createElement("TextLabel", {
                Text = name,
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBlack,
                TextSize = 16
            })
        })
    })
end

return MenuButton