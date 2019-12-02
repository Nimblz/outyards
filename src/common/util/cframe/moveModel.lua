return function(model, newCFrame, cache)
    assert(model.PrimaryPart,
        ("%s has no primary part. Cannot create cache."):format(
            model:GetFullName()
        ))

    local root = model.PrimaryPart

    root.CFrame = newCFrame
    for part, cframe in pairs(cache) do
        part.CFrame = newCFrame * cframe
    end
end