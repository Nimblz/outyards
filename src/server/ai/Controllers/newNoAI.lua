local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

return function(entity, recs, pz)
    -- stuff only the state machine cares about, things that might be useful to have access to between states
    local driver = recs:getComponent(entity, recs:getComponentClass("NPCDriver"))
    local props = {}
    return {
        awake = {
            enter = function()
                return "idle"
            end,
            step = function()
            end,
        },
        idle = {
            enter = function()
                driver:updateProperty("targetVelocity", Vector3.new(0,0,0))
                entity.Anchored = true
            end,
            step = function()
            end,
        },
        dead = { -- entered when health reaches zero. will yield until previous state's enter is finished
            enter = function()
            end,
            step = function()
            end,
        },
    }
end