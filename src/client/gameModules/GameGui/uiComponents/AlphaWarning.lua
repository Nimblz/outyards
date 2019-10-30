local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local FullScreenModal = require(component:WaitForChild("FullScreenModal"))
local FitList = require(component:WaitForChild("FitList"))
local FitText = require(component:WaitForChild("FitText"))
local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FancyButton = require(component:WaitForChild("FancyButton"))

local AlphaWarning = Roact.Component:extend("AlphaWarning")

function AlphaWarning:init()
    self:setState(function()
        return {
            visible = true
        }
    end)
end

function AlphaWarning:hide()
    self:setState(function()
        return {
            visible = false
        }
    end)
end

function AlphaWarning:didMount()
end

function AlphaWarning:render()
    return self.state.visible and Roact.createElement(FullScreenModal, {}, {
        centerFrame = Roact.createElement(FitList, {
            containerKind = RoundFrame,
            paddingProps = {
                PaddingTop = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
            },
            layoutProps = {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0,16),
            },
            containerProps = {
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
            },
            minSize = Vector2.new(300,200),
        }, {
            heading = Roact.createElement(FitText, {
                Text = "WARNING",
                Font = Enum.Font.GothamBlack,
                TextSize = 48,
                LayoutOrder = 1,
            }),
            body = Roact.createElement(FitText, {
                Text = "Outyards is in early alpha. Things will change a lot. Data may be wiped. Dont say I didn't warn you!",
                TextSize = 24,
                LayoutOrder = 2,
                TextWrapped = true,
                fitAxis = "Y",
                Size = UDim2.new(0,600,0,0),
            }),
            button = Roact.createElement(FitList, {
                containerKind = FancyButton,
                containerProps = {
                    color = Color3.fromRGB(255, 162, 40),
                    Size = UDim2.new(0,200,0,50),
                    LayoutOrder = 3,
                    [Roact.Event.Activated] = function() self:hide() end
                },
                layoutProps = {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                },
                paddingProps = {
                    PaddingTop = UDim.new(0,16),
                    PaddingBottom = UDim.new(0,16),
                    PaddingLeft = UDim.new(0,16),
                    PaddingRight = UDim.new(0,16),
                },
                minSize = Vector2.new(200,0)
            }, {
                Roact.createElement(FitText, {
                    Text = "I understand",
                    TextSize = 24,
                })
            }),
        })
    })
end

return AlphaWarning