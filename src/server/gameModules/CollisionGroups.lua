local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

--local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
--local event = ReplicatedStorage:WaitForChild("event")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local CollisionGroups = PizzaAlpaca.GameModule:extend("CollisionGroups")

function CollisionGroups:preInit()
    PhysicsService:CreateCollisionGroup("players")
    PhysicsService:CreateCollisionGroup("monsters")
    PhysicsService:CollisionGroupSetCollidable("players","monsters",false)
    PhysicsService:CollisionGroupSetCollidable("players","players",false)

    Players.PlayerAdded:connect(function(player)
        player.CharacterAdded:connect(function(char)
            wait(1)
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    print("nocolliding")
                    PhysicsService:SetPartCollisionGroup(v,"players")
                end
            end
        end)
    end)

    for _,p in pairs(Players:GetPlayers()) do
        p.CharacterAdded:connect(function(char)
            wait(1)
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    print("nocolliding")
                    PhysicsService:SetPartCollisionGroup(v,"players")
                end
            end
        end)
    end
end

function CollisionGroups:init()
end

function CollisionGroups:postInit()
end

return CollisionGroups