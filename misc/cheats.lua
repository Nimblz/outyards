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