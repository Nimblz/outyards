local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local StatsBar = Roact.Component:extend("StatsBar")
local StatsLabel = require(script:WaitForChild("StatsLabel"))

local DEFAULT_WALKSPEED = StarterPlayer.CharacterWalkSpeed
local PADDING = 32

function StatsBar:init()
end

function StatsBar:didMount()
end

function StatsBar:render()
    local baseDamage = self.props.baseDamage or 1
    local defense = self.props.defense or 0
    local moveSpeed = self.props.moveSpeed or 16

    local buttons = {}

    buttons.layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0,PADDING),
        FillDirection = Enum.FillDirection.Horizontal,
    })

    buttons.damage = Roact.createElement(StatsLabel, {
        iconImage = "rbxassetid://3992000796",
        statValue = baseDamage,
        layoutOrder = 1,
    })

    buttons.defense = Roact.createElement(StatsLabel, {
        iconImage = "rbxassetid://3992000457",
        statValue = defense,
        layoutOrder = 2,
    })

    buttons.speed = Roact.createElement(StatsLabel, {
        iconImage = "rbxassetid://3992000115",
        statValue = moveSpeed,
        layoutOrder = 3,
    })

    return Roact.createElement("Frame", {
        Size = UDim2.new(0.5,0,0,100),
        Position = UDim2.new(0.5,0,0,PADDING),
        AnchorPoint = Vector2.new(0.5,0),
        BackgroundTransparency = 1,
    },buttons)
end


local function mapStateToProps(state,props)
    return {
        baseDamage = Selectors.getBaseDamage(state,LocalPlayer),
        defense = Selectors.getDefense(state,LocalPlayer),
        moveSpeed = Selectors.getMoveSpeed(state,LocalPlayer) - DEFAULT_WALKSPEED,
    }
end

StatsBar = RoactRodux.connect(mapStateToProps)(StatsBar)

return StatsBar