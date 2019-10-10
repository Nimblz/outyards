local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local EquipmentReplicator = PizzaAlpaca.GameModule:extend("EquipmentReplicator")

local eEquipmentUpdated = event:WaitForChild("eEquipmentUpdated")
local eUpdateEquipmentProps = event:WaitForChild("eUpdateEquipmentProps")
local eEquipmentActivated = event:WaitForChild("eEquipmentActivated")
local eEquipmentDeactivated = event:WaitForChild("eEquipmentDeactivated")

local function playerKey(player)
    return player
end

function EquipmentReplicator:create()
    self.props = {} -- props[player][id]
end

function EquipmentReplicator:getAllProps(player)
    return self.props[playerKey(player)]
end

function EquipmentReplicator:getProps(player,id)
    return self:getAllProps(player)[id]
end

function EquipmentReplicator:setProps(player,id,props)
    self:getAllProps(player)[id] = props
end

function EquipmentReplicator:playerAdded(player)
    self.props[playerKey(player)] = {}
end

function EquipmentReplicator:playerLeaving(player)
    self.props[playerKey(player)] = nil
end

function EquipmentReplicator:postInit()

    Players.playerAdded:connect(function(player)
        self:playerAdded(player)
    end)

    Players.PlayerRemoving:connect(function(player)
        self:playerLeaving(player)
    end)

    for _,player in pairs(Players:GetPlayers()) do
        self:playerAdded(player)
    end

    eUpdateEquipmentProps.OnServerEvent:connect(function(player,id,props)
        assert(id, "Invalid id")
        assert(typeof(id)=="string", "Invalid id")
        assert(props, "Invalid props")
        assert(typeof(props)=="table", "Invalid props")

        HttpService:JSONEncode(props) -- quick and dirty sanitizer, will throw if props are malformed

        self:setProps(player,id,props)
    end)

    coroutine.wrap(function()
        while true do
            wait(1/15)
            -- broadcast current props to clients
            for player, props in pairs(self.props) do
                eEquipmentUpdated:FireAllClients(player,props)
            end
        end
    end)()

    eEquipmentActivated.OnServerEvent:connect(function(sourcePlayer,id,props)
        -- TODO: Validate activation.
        -- Player must own the item they're using and have not activated it within the last fireRate*userAttackRate
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= sourcePlayer then
                eEquipmentActivated:FireClient(player,sourcePlayer,id,props)
            end
        end
    end)

    eEquipmentDeactivated.OnServerEvent:connect(function(sourcePlayer,id)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= sourcePlayer then
                eEquipmentDeactivated:FireClient(player,sourcePlayer,id)
            end
        end
    end)
end

return EquipmentReplicator