local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)

local InteractableTarget = Roact.PureComponent:extend("InteractableTarget")

function InteractableTarget:render()
    if self.props.targetInteractable then
        local instanceRoot = self.props.targetInteractable
        if instanceRoot:IsA("Model") then
            instanceRoot = instanceRoot.PrimaryPart or instanceRoot:FindFirstChildOfClass("BasePart")
            warn("Invalid interactable:", instanceRoot)
            if not instanceRoot then return end
        end

        local interactableBillboard = Roact.createElement("BillboardGui", {
            Adornee = instanceRoot,
            AlwaysOnTop = true,
            ResetOnSpawn = false,
            Size = UDim2.new(3,0,3,0),
            MaxDistance = 64,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        }, {
            image = Roact.createElement("ImageLabel", {
                Image = "rbxassetid://3202644510",
                BackgroundTransparency = 1,
                Size = UDim2.new(.75,0,.75,0),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                BorderSizePixel = 0,
                ImageRectOffset = Vector2.new(10,10),
                ImageRectSize = Vector2.new(80,80),
            }),
            text = Roact.createElement("TextLabel", {
                Text = "Interact",
                TextScaled = true,
                Font = Enum.Font.GothamBlack,
                TextColor3 = Color3.new(1,1,1),
                TextStrokeTransparency = 0.8,
                Size = UDim2.fromScale(1,0.25),
                BackgroundTransparency = 1,
            }),
            layout = Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
            })
        })

        return Roact.createElement(Roact.Portal, {
            target = PlayerGui
        }, {
            interactableBillboard = interactableBillboard
        })
    end
end

local function mapStateToProps(state, props)
    return {
        targetInteractable = Selectors.getTargetInteractable(state)
    }
end

InteractableTarget = RoactRodux.connect(mapStateToProps,nil)(InteractableTarget)

return InteractableTarget