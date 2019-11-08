-- keeps track of where the player wants to shoot
-- handles lock-on targeting for mobile
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib

local PizzaAlpaca = require(lib.PizzaAlpaca)

local Targeting = PizzaAlpaca.GameModule:extend("Targeting")

local function getScreenSize()
    return Workspace.CurrentCamera.ViewportSize
end

local function camRayFromMousePos(mousePos)
    local cam = Workspace.CurrentCamera
    if not cam then return end

    return cam:ScreenPointToRay(mousePos.X,mousePos.Y,1)
end

function Targeting:isOnScreen(instance)
    local pos = instance.Position
    local screenPos, onScreen = Workspace.CurrentCamera:WorldToScreenPoint(pos)
    if onScreen then
        -- cast a ray to make sure it's not covered
        local camRay = camRayFromMousePos(screenPos)
        local target, _, _ = Workspace:FindPartOnRayWithWhitelist(
            Ray.new(camRay.Origin,camRay.Direction*512),
            {self.world, instance}
        )

        if target == instance then return true end
    end

    return false
end



function Targeting:create()
    self.autoTargetEnabled = UserInputService.TouchEnabled
end

function Targeting:getClosestEnemy()
    local enemies = Workspace:FindFirstChild("enemies")

    local char = LocalPlayer.Character
    if not char then return end
    local root = char.PrimaryPart
    if not root then return end
    local charPos = root.Position
    local closestDist = math.huge
    local closestEnemy

    for _, child in pairs(enemies:GetDescendants()) do
        if child:IsA("BasePart") and CollectionService:HasTag(child, "ActorStats") then
            local dist = (child.Position - charPos).Magnitude

            if dist < closestDist and dist < 512 and self:isOnScreen(child) then
                closestDist = dist
                closestEnemy = child
            end
        end
    end

    return closestEnemy
end

function Targeting:getTargetInfo()
    if not self.autoTargetEnabled then
        local inputHandler = self.core:getModule("InputHandler")
        local screenPos = inputHandler:getMousePos()
        local camRay = camRayFromMousePos(screenPos)
        local target, worldPos, worldNormal = Workspace:FindPartOnRayWithWhitelist(
            Ray.new(camRay.Origin,camRay.Direction*2048),
            {self.world,self.enemies}
        )

        return {
            mouse = {
                screenPos = inputHandler:getMousePos(),
                worldPos = worldPos,
                worldNormal = worldNormal,
                hit = CFrame.new(worldPos,worldPos + worldNormal),
                target = target,
            }
        }
    else
        -- fallback to center of screen
        local screenSize = getScreenSize()
        local fallbackScreenPos = Vector2.new(screenSize.X/2, screenSize.Y/4)
        local camRay = camRayFromMousePos(fallbackScreenPos)
        local fallbackTarget, fallbackWorldPos, fallbackWorldNormal = Workspace:FindPartOnRayWithWhitelist(
            Ray.new(camRay.Origin,camRay.Direction*2048),
            {self.world,self.enemies}
        )

        local fallback = {
            mouse = {
                screenPos = fallbackScreenPos,
                worldPos = fallbackWorldPos,
                worldNormal = fallbackWorldNormal,
                hit = CFrame.new(fallbackWorldPos, fallbackWorldPos + fallbackWorldNormal),
                target = fallbackTarget,
            }
        }

        local closestEnemy = self:getClosestEnemy()
        if not closestEnemy then return fallback end
        local char = LocalPlayer.Character
        if not char then return fallback end
        local root = char.PrimaryPart
        if not root then return fallback end
        local charPos = root.Position
        local worldPos = closestEnemy.Position
        local screenPos = Workspace.CurrentCamera:WorldToScreenPoint(worldPos)
        local diffVector = (worldPos - charPos).Unit

        return {
            mouse = {
                screenPos = screenPos,
                worldPos = worldPos,
                worldNormal = diffVector,
                hit = CFrame.new(worldPos, worldPos + diffVector),
                target = closestEnemy
            }
        }
    end
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