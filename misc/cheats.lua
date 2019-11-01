-- kill everything
_G.killing = true

while _G.killing do
    for _, child in pairs(workspace.enemies:GetDescendants()) do
        if child:IsA("BasePart") then
            game.ReplicatedStorage.event.eAttackActor:FireServer(child)
            wait()
        end
    end
    wait()
end

-- WIPE SAVE --

local playerName = "Nimblz"
local player = game.Players:FindFirstChild(playerName)
local action = {type = "PLAYER_ADD", player = player, saveData = {}, replicateTo = player}
_G.store:dispatch(action)

-- ADD ITEM --

local playerName = "Nimblz"
local player = game.Players:FindFirstChild(playerName)
local action = {type = "ITEM_ADD", player = player, itemId = "wood", quantity = 10, replicateTo = player}
_G.store:dispatch(action)

