local Workspace = game:GetService("Workspace")

return function()
    local currentCamera = Workspace.CurrentCamera

    return currentCamera.ViewportSize
end