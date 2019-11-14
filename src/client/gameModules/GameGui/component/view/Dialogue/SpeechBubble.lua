local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)

local SpeechBubble = Roact.PureComponent:extend("SpeechBubble")

local RounderFrame = require(component.RounderFrame)
local FitList = require(component.FitList)
local FitText = require(component.FitText)

function SpeechBubble:render()
    local speaker = self.props.speaker or "???"
    local text = self.props.text or "(Something is said but you cant quite make it out)"

    local speechFrame = Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(600,150),
        LayoutOrder = 1,
    }, {
        bubble = Roact.createElement(RounderFrame, {
            Size = UDim2.fromScale(1,1),
        }, {
            padding = Roact.createElement("UIPadding", {
                PaddingBottom = UDim.new(0,24),
                PaddingTop = UDim.new(0,35),
                PaddingLeft = UDim.new(0,80),
                PaddingRight = UDim.new(0,80),
            }),
            text = Roact.createElement("TextLabel", {
                Size = UDim2.fromScale(1,1),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamSemibold,
                TextSize = 22,
                LineHeight = 1.2,
                Text = text,
                TextWrapped = true,
                TextColor3 = Color3.new(0,0,0),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            })
        }),
        speaker = Roact.createElement(FitList, {
            fitAxes = "X",
            minSize = Vector2.new(200,50),
            containerKind = RounderFrame,
            containerProps = {
                color = Color3.new(0,0,0),
                Size = UDim2.new(0,0,0,50),
                AnchorPoint = Vector2.new(0,0.5),
                Position = UDim2.new(0,25,0,0),
                ZIndex = 2,
            },
            layoutProps = {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            },
            paddingProps = {
                PaddingBottom = UDim.new(0,4),
                PaddingTop = UDim.new(0,4),
                PaddingLeft = UDim.new(0,32),
                PaddingRight = UDim.new(0,32),
            }
        }, {
            name = Roact.createElement(FitText, {
                fitAxis = "XY",
                Text = speaker,
                Font = Enum.Font.GothamBlack,
                TextSize = 32,
                TextColor3 = Color3.new(1,1,1),
            })
        })
    })

    return speechFrame
end

return SpeechBubble