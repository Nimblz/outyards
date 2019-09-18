local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local ActorStatsSystem = RECS.System:extend("ActorStatsSystem")

function ActorStatsSystem:init()
    self.core:getComponentAddedSignal(RecsComponents.ActorStats):connect(function(instance,component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.ActorStats):connect(function(instance,component)
    end)
end

function ActorStatsSystem:step()
end

return ActorStatsSystem