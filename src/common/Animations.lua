local function newAnimation(name,id)
    local newAnim = Instance.new("Animation")
    newAnim.AnimationId = id
    newAnim.Name = name
    return newAnim
end

return {
    toolhold = newAnimation("hold","rbxassetid://507768375"),
    offHandHold = newAnimation("offHandHold","rbxassetid://04178278456"),
    swing = newAnimation("swing", "rbxassetid://04093489126"),
    backswing = newAnimation("backswing", "rbxassetid://04093501278"),
    pickswing = newAnimation("pickswing", "rbxassetid://04093472220"),

    r6run = newAnimation("r6run", "rbxassetid://180426354"),
    r6idle = newAnimation("r6idle", "rbxassetid://180435571"),
    r6attack = newAnimation("r6attack", "rbxassetid://4192868719")
}