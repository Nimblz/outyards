local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")
local util = common.util

local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local beautifyNumber = require(util.beautifyNumber)

local RoundFrame = require(component.RoundFrame)
local withScale = require(component.withScale)
local HealthBar = Roact.Component:extend("HealthBar")

local HEIGHT = 32
local WIDTH = 300

local RoundFrameWithScale = withScale(RoundFrame, {
    defaultSize = Vector2.new(1280,600),
    scale = 1,
    minScale = 0.5,
    maxScale = 1,
    scaleIncrement = 0.25,
})

function HealthBar:init()
    self:setState({
        humanoid = nil,
        health = 1,
        maxHealth = 1,
    })
end

function HealthBar:setHumanoidFromCharacter(char)
    if not char then return end
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.Died:connect(function()
        self.state.humanoidChangedConnection:disconnect()
    end)
    self:setState({
        humanoid = humanoid,
        humanoidChangedConnection = humanoid.Changed:connect(function()
            self:healthChanged()
        end),

        health = humanoid.Health,
        maxHealth = humanoid.MaxHealth,
    })
end

function HealthBar:healthChanged()
    local humanoid = self.state.humanoid
    self:setState({
        humanoid = humanoid,
        humanoidChangedConnection = self.state.humanoidChangedConnection,
        health = humanoid.Health,
        maxHealth = humanoid.MaxHealth,
    })
end

function HealthBar:didMount()
    coroutine.wrap(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
        self:setHumanoidFromCharacter(character)
        LocalPlayer.CharacterAdded:connect(function(char)
            self:setHumanoidFromCharacter(char)
        end)
    end)()
end

function HealthBar:render()
    local children = {}

    local healthRatio = self.state.health/self.state.maxHealth
    healthRatio = math.clamp(healthRatio,0,1)

    local beautifiedHealth = beautifyNumber(math.floor(self.state.health))
    local beautifiedMaxHealth = beautifyNumber(math.floor(self.state.maxHealth))

    children.clippyFrame = Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Size = UDim2.new(healthRatio,0,1,0),
    }, {
        greenFrame = Roact.createElement(RoundFrame, {
            AnchorPoint = Vector2.new(0,0),
            Size = UDim2.new(0,300,1,0),
            Position = UDim2.new(0,0,0,0),
            BorderSizePixel = 0,
            color = Color3.fromRGB(102, 255, 0)
        })
    })

    children.healthText = Roact.createElement("TextLabel", {
        Text = "   "..beautifiedHealth.." / "..beautifiedMaxHealth,
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(0,0,0),
        Font = Enum.Font.GothamBlack,
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
    })

    return Roact.createElement(RoundFrameWithScale, {
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,0,32),
        Size = UDim2.new(0,WIDTH,0,HEIGHT),
        color = Color3.fromRGB(197, 0, 0),
        Visible = self.props.visible
    }, children)
end

local function mapStateToProps(state, props)
    return {
        visible = Selectors.getHealthbarVisible(state),
    }
end

HealthBar = RoactRodux.connect(mapStateToProps)(HealthBar)

return HealthBar