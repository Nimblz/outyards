return function(model)
    assert(model.PrimaryPart,
        ("%s has no primary part. Cannot create cache."):format(
            model:GetFullName()
        ))

    local root = model.PrimaryPart

    local offsets = {}

    for _, child in pairs(model:GetChildren()) do
        if not child == root then
            local offset = root.CFrame:Inverse() * child.CFrame
            offsets[child] = offset
        end
    end

    return offsets
end