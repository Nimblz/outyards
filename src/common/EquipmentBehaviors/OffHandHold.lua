local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Animations = require(common:WaitForChild("Animations"))

local behavior = {
    id = "offHandHold"
}

function behavior:create()
    local humanoid = self.character:FindFirstChild("Humanoid")
    if not humanoid then return end

    local holdAnimation = Animations.offHandHold

    self.holdTrack = humanoid:LoadAnimation(holdAnimation)
end

function behavior:activated(props)
    self.props = props
end

function behavior:deactivated()
end

function behavior:recieveProps(newProps)
    self.props = newProps
end

function behavior:update()
end

function behavior:equipped()
    self.holdTrack:play()
end

function behavior:unequipped()
    self.holdTrack:stop()
end

function behavior:destroy()
end

return behavior