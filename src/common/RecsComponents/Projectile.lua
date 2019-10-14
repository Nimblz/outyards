local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "Projectile",
    generator = function(props)
        props = props or {}
        return {
            id = props.id or "bullet",
            position = props.position or Vector3.new(0,0,0), -- per sec
            velocity = props.velocity or Vector3.new(0,0,0),
            gravityScale = props.gravityScale or 1,
            fireTime = props.fireTime or 0,
            owner = props.owner, -- player who owns this projectile, nil if server owned
            owned = props.owner == LocalPlayer,
            damagesPlayers = false, -- does this projectile damage players? server created projectiles often will
        }
    end,
})