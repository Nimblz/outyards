local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Roact = require(lib:WaitForChild("Roact"))
local CodeLabLogo = Roact.Component:extend("CodeLabLogo")

local CODELAB_LOGO_IMAGE = "rbxassetid://3310888975"

local BINARY_STRING_1 = "101100101101101101001"
local BINARY_STRING_2 = "001011010111010101100"

local BINARY_FONT = Enum.Font.Code

local NUM_BINARY_ROWS = 10
local BINARY_LABEL_HEIGHT = 22
local BINARY_ROW_PADDING = 2

local BINARY_CYCLES_PER_SEC = (1/256)*60

local function alphaFromTime(t)
    return (t*BINARY_CYCLES_PER_SEC)%1
end

local function binaryLabel(string, offset, children)
    return Roact.createElement("TextLabel", {
        Size = UDim2.new(1,0,0,BINARY_LABEL_HEIGHT),
        BackgroundTransparency = 1,
        Position = offset,

        TextColor3 = Color3.fromRGB(255,255,255),
        Text = string or BINARY_STRING_1,
        TextSize = 24,
        Font = BINARY_FONT,
    }, children)
end

function CodeLabLogo:init(initialProps)
    self:updateBinary(tick())
end

function CodeLabLogo:render()

    local alpha = self.state.alpha

    local binaryFrameChildren = {}

    binaryFrameChildren.binaryLayout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0,BINARY_ROW_PADDING),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    for i = 1, NUM_BINARY_ROWS do
        local isOdd = (i%2 ~= 0)
        -- offset alpha using some magic numbers to break up grid
        local offset = math.noise(i*1.3625123/NUM_BINARY_ROWS*1.737132)
        local ofsetAlpha = (alpha+offset)%1
        local binaryString = (isOdd and BINARY_STRING_1) or BINARY_STRING_2

        local binaryLabelFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1,0,0,BINARY_LABEL_HEIGHT),
            BackgroundTransparency = 1,
            LayoutOrder = i,
        }, {
                binaryLabel(
                    binaryString,
                    UDim2.new((isOdd and 1-ofsetAlpha) or (ofsetAlpha),0,0,0), {
                        binaryLabel(
                            binaryString,
                            UDim2.new((isOdd and -1) or (-1),0,0,0)
                        )
                    }
                )
            }
        )
        binaryFrameChildren["binaryFrame_"..i] = binaryLabelFrame
    end

    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        Size = UDim2.new(0,256,0,256),

        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(32, 34, 37),
        ClipsDescendants = true
    }, {
        logoLabel = Roact.createElement("ImageLabel", {
            Size = UDim2.new(1,0,1,0),

            BackgroundTransparency = 1,

            Image = CODELAB_LOGO_IMAGE,
        }),
        binaryFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1,0,1,0),

            BackgroundTransparency = 1,
        }, binaryFrameChildren)
    })
end

function CodeLabLogo:updateBinary()
    self:setState({
        alpha = alphaFromTime(tick()),
    })
end

function CodeLabLogo:didMount()
    self.animationConnection = RunService.RenderStepped:connect(function()
        self:updateBinary(tick())
    end)
end

function CodeLabLogo:willUnmount()
    if self.animationConnection then self.animationConnection:disconnect() end
end

return CodeLabLogo