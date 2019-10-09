local function newAnimation(name,id)
    local newAnim = Instance.new("Animation")
    newAnim.AnimationId = id
    newAnim.Name = name
    return newAnim
end

return {
    toolhold = newAnimation("hold","rbxassetid://507768375"),
    swing = newAnimation("swing", "rbxassetid://667286531"),
    backswing = newAnimation("backswing", "rbxassetid://667318897"),
    pickswing = newAnimation("pickswing", "rbxassetid://666865136"),
}