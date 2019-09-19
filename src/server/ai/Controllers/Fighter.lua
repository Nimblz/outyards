local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local StateMachine = require(lib:WaitForChild("StateMachine"))
local Dictionary = require(util:WaitForChild("Dictionary"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local StateGraphs = require(script.Parent.Parent:WaitForChild("StateGraphs"))

local Fighter = {}

local function pointsCloserThan(p1,p2,dist)
    local delta = p1-p2

    return ((delta.X*delta.X) + (delta.Y*delta.Y) + (delta.Z*delta.Z)) <= dist*dist
end

local function findCharacterNear(instance, radius)
    local closestDist = radius
    local closestChar
    for _, player in pairs(Players:getPlayers()) do
        local character = player.character
        if not character then return end
        local root = character.PrimaryPart
        if not root then return end
        if pointsCloserThan(root.CFrame.p , instance.CFrame.p, closestDist) then
            closestChar = character
        end
    end

    return closestChar
end

function Fighter.new(entity, recs, pzCore)
    local self = setmetatable({},{__index = Fighter})

    local graph = StateGraphs.BasicHostile

    local machineOptions = Dictionary.join(graph, {
        callbacks = {
            onidle = function() self:onidle() end,
            onchase = function() self:onchase() end,
        }
    })

    self.fsm = StateMachine.create(machineOptions)
    self.entity = entity
    self.actorStats = recs:getComponent(entity, RecsComponents.ActorStats)

    self.fsm:initialize()

    return self
end

function Fighter:onidle()
    while true do
        local character = findCharacterNear(self.entity, self.actorStats.aggroRadius)
        if character then
            return self.fsm:chase(character)
        end
        wait(1)
    end
end

function Fighter:onchase()
    print("im angry!")
end

return Fighter