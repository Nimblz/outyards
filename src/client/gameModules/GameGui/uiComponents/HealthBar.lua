local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local component = script:FindFirstAncestor("uiComponents")
local util = common:WaitForChild("util")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local beautifyNumber = require(util:WaitForChild("beautifyNumber"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local HealthBar = Roact.Component:extend("HealthBar")

local HEIGHT = 32
local WIDTH = 300

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
            self:healthChanged(humanoid.Health, humanoid.MaxHealth)
        end),

        health = humanoid.Health,
        maxHealth = humanoid.MaxHealth,
    })
end

function HealthBar:healthChanged(newHealth,newMaxhealth)
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
    })

    return Roact.createElement(RoundFrame, {
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,0,HEIGHT*2),
        Size = UDim2.new(0,WIDTH,0,HEIGHT),
        color = Color3.fromRGB(197, 0, 0),
        Visible = self.props.visible
    }, children)
end

local function mapStateToProps(state,props)
    return {
        visible = Selectors.getHealthbarVisible(state),
    }
end

HealthBar = RoactRodux.connect(mapStateToProps)(HealthBar)

return HealthBar