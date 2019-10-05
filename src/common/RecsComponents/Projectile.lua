local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "Projectile",
    generator = function(props)
        props = props or {}
        return {
            id = "bullet",
            position = props.position or Vector3.new(0,0,0), -- per sec
            velocity = props.velocity or Vector3.new(0,0,0),
            gravityScale = props.gravityScale or 1,
            owner = nil, -- player who owns this projectile, nil if server owned
            damagesPlayers = false, -- does this projectile damage players? server created projectiles often will
        }
    end,
})