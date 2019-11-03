-- keeps track of where the player wants to shoot
-- handles lock-on targeting for mobile
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local Targeting = PizzaAlpaca.GameModule:extend("Targeting")

local function camRayFromMousePos(mousePos)
    local cam = Workspace.CurrentCamera
    if not cam then return end

    return cam:ScreenPointToRay(mousePos.X,mousePos.Y,1)
end

function Targeting:getTargetInfo()
    local inputHandler = self.core:getModule("InputHandler")
    local screenPos = inputHandler:getMousePos()
    local camRay = camRayFromMousePos(screenPos)
    local target, worldPos, worldNormal = Workspace:FindPartOnRayWithWhitelist(
        Ray.new(camRay.Origin,camRay.Direction*2048),
        {self.world,self.enemies}
    )

    local inputProps = {
        mouse = {
            screenPos = inputHandler:getMousePos(),
            worldPos = worldPos,
            worldNormal = worldNormal,
            hit = CFrame.new(worldPos,worldNormal),
            target = target,
        }
    }

    return inputProps
end

function Targeting:preInit()
end

function Targeting:init()
    self.world = Workspace:WaitForChild("world")
    self.enemies = Workspace:WaitForChild("enemies")
end

function Targeting:postInit()
end

return Targeting