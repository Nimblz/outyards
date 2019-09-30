local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local HealthBar = Roact.Component:extend("HealthBar")

local HEIGHT = 30
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
    print("Mounting HealthBar")
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
    self:setHumanoidFromCharacter(character)
    LocalPlayer.CharacterAdded:connect(function(char)
        self:setHumanoidFromCharacter(char)
    end)
end

function HealthBar:render()
    local children = {}

    local healthRatio = self.state.health/self.state.maxHealth

    children.greenFrame = Roact.createElement("Frame", {
        Size = UDim2.new(healthRatio,0,1,0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(90, 224, 0)
    })

    children.healthText = Roact.createElement("TextLabel", {
        Text = " "..tostring(math.floor(self.state.health)).." / "..tostring(self.state.maxHealth),
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.GothamBlack,
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,3/4,0),
        Size = UDim2.new(0,WIDTH,0,HEIGHT),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(192, 0, 0),
        BorderSizePixel = 0,
    }, children)
end

return HealthBar