local function newAnimation(name,id)
    local newAnim = Instance.new("Animation")
    newAnim.AnimationId = id
    newAnim.Name = name
    return newAnim
end

return {
    toolhold = newAnimation("hold","rbxassetid://507768375"),
    swing = newAnimation("swing", "rbxassetid://04093489126"),
    backswing = newAnimation("backswing", "rbxassetid://04093501278"),
    pickswing = newAnimation("pickswing", "rbxassetid://04093472220"),
}