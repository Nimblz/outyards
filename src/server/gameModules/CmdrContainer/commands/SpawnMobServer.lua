local server = script:FindFirstAncestor("server")
local npc = server:WaitForChild("npc")

local createNPC = require(npc:WaitForChild("createNPC"))

return function(context, npcType)
    local executor = context.Executor
    local character = executor.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local npcSpawnCF = root.CFrame * CFrame.new(0, 0, -10)

            local recsCore = context.State.recsCore

            createNPC(recsCore, npcType, npcSpawnCF)
        end
    end
end