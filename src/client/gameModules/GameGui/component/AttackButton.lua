local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local UserInputService = game:GetService("UserInputService")

local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)

local AttackButton = Roact.Component:extend("AttackButton")

local JUMP_BUTTON_OFFSET = Vector2.new(-25,-90)
local BUTTON_SIZE = 70
local PADDING = 16

function AttackButton:init()
    self.pzCore = self._context.pzCore
end

function AttackButton:startAttack()
    local inputHandler = self.pzCore:getModule("InputHandler")

    inputHandler:fireActionState("attack", Enum.UserInputState.Begin)
end

function AttackButton:endAttack()
    local inputHandler = self.pzCore:getModule("InputHandler")

    inputHandler:fireActionState("attack", Enum.UserInputState.End)
end

function AttackButton:render()
    local touchEnabled = UserInputService.TouchEnabled

    local attackButton = Roact.createElement("ImageButton", {
        AnchorPoint = Vector2.new(1,1),
        Size = UDim2.new(0,BUTTON_SIZE,0,BUTTON_SIZE),
        Position = UDim2.new(1, JUMP_BUTTON_OFFSET.X, 1, JUMP_BUTTON_OFFSET.Y - PADDING),

        BackgroundTransparency = 1,

        Image = "rbxassetid://4281738985",
        PressedImage = "rbxassetid://4281739483",

        [Roact.Event.MouseButton1Down] = function() self:startAttack() end,
        [Roact.Event.MouseButton1Up] = function() self:endAttack() end,
    })

    local modal = Roact.createElement("ScreenGui", {
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 10,
    }, {
        attackButton = attackButton,
    })

    local portal = Roact.createElement(Roact.Portal, {
        target = PlayerGui
    }, {
        attackGui = modal
    })
    return touchEnabled and portal
end

return AttackButton