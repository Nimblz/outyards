local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local common = ReplicatedStorage.common
local util = common.util
local lib = ReplicatedStorage.lib
local lightingAreas = ReplicatedStorage.lightingAreas

local pointIsInPart = require(util.pointIsInPart)

local PizzaAlpaca = require(lib.PizzaAlpaca)
local AreaLighting = PizzaAlpaca.GameModule:extend("AreaLighting")

local currentArea = nil
local transitioningFrom = nil

local INSTANT = newproxy()
local SMOOTH = newproxy()

local areas = {
    default = {
        lightingProps = {
            Ambient = Color3.fromRGB(61, 63, 76),
            Brightness = 2,
            GlobalShadows = true,
            ShadowSoftness = 1,
            OutdoorAmbient = Color3.fromRGB(127, 127, 127),
            ClockTime = 13,
            ExposureCompensation = 0,
            FogColor = Color3.fromRGB(151, 198, 213),
            FogEnd = 10000,
            FogStart = 3000,
        },
        transitionToTypes = {
            desert = SMOOTH,
            crimsonpath = SMOOTH,
            tundra = SMOOTH,
            underwater = INSTANT,
        }
    },

    tundra = {
        lightingProps = {
            Ambient = Color3.fromRGB(61, 63, 76),
            Brightness = 2,
            GlobalShadows = true,
            ShadowSoftness = 1,
            OutdoorAmbient = Color3.fromRGB(127, 127, 127),
            ClockTime = 13,
            ExposureCompensation = 0,
            FogColor = Color3.fromRGB(151, 198, 213),
            FogEnd = 10000,
            FogStart = 3000,
        },
        transitionToTypes = {
            default = SMOOTH,
            desert = SMOOTH,
            crimsonpath = SMOOTH,
            tundra = SMOOTH,
            underwater = INSTANT,
        }
    },

    desert = {
        lightingProps = {
            Ambient = Color3.fromRGB(61, 63, 76),
            Brightness = 2,
            GlobalShadows = true,
            ShadowSoftness = 1,
            OutdoorAmbient = Color3.fromRGB(127, 127, 127),
            ClockTime = 13,
            ExposureCompensation = 0,
            FogColor = Color3.fromRGB(151, 198, 213),
            FogEnd = 10000,
            FogStart = 3000,
        },
        transitionToTypes = {
            default = SMOOTH,
            desert = SMOOTH,
            crimsonpath = SMOOTH,
            tundra = SMOOTH,
            underwater = INSTANT,
        }
    },

    crimsonpath = {
        lightingProps = {
            Ambient = Color3.fromRGB(53, 0, 0),
            Brightness = 1,
            GlobalShadows = true,
            ShadowSoftness = 1,
            OutdoorAmbient = Color3.fromRGB(157, 121, 122),
            ClockTime = 2.4,
            ExposureCompensation = 0,
            FogColor = Color3.fromRGB(61, 0, 26),
            FogEnd = 2000,
            FogStart = 0,
        },
        transitionToTypes = {
            default = SMOOTH,
            desert = SMOOTH,
            crimsonpath = SMOOTH,
            tundra = SMOOTH,
            underwater = INSTANT,
        }
    },
}

local targetLightingProps = {

}

local function lerp(x,y,a)
    return x + ((y-x)*a)
end

local function color3lerp(x,y,a)
    return Color3.new(
        lerp(x.R,y.R,a),
        lerp(x.G,y.G,a),
        lerp(x.B,y.B,a)
    )
end

local function changeArea(newAreaName)
    assert(areas[newAreaName], ("Invalid area %s"):format(tostring(newAreaName)))

    if currentArea ~= newAreaName then
        local newAreaLighting = areas[newAreaName]
        transitioningFrom = areas[currentArea]
        for prop,value in pairs(newAreaLighting.lightingProps) do
            targetLightingProps[prop] = value
        end
        currentArea = newAreaName
    end
end

local function updateLighting()
    local camera = Workspace.CurrentCamera
    local camPos = camera.CFrame.p

    -- check against lighting areas
    local newArea = "default"

    for _,areaBounds in pairs(lightingAreas:GetDescendants()) do
        if areaBounds:IsA("BasePart") and areas[areaBounds.Name] then
            if pointIsInPart(camPos,areaBounds) then
                newArea = areaBounds.Name
            end
        end
    end

    changeArea(newArea)

    -- transition lighting

    for prop, val in pairs(targetLightingProps) do
        if transitioningFrom and transitioningFrom.transitionToTypes then
            if transitioningFrom.transitionToTypes[currentArea] == SMOOTH then
                if typeof(val) == "Color3" then
                    Lighting[prop] = color3lerp(Lighting[prop],val,0.005)
                elseif typeof(val) == "number" then
                    Lighting[prop] = lerp(Lighting[prop],val,0.005)
                else
                    Lighting[prop] = val
                end
            else
                Lighting[prop] = val
            end
        else
            Lighting[prop] = val
        end
    end
end

function AreaLighting:init()
    changeArea("default")
    RunService.RenderStepped:Connect(function()
        updateLighting()
    end)
end

return AreaLighting