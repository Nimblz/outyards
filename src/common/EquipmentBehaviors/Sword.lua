local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Animations = require(common:WaitForChild("Animations"))

local eAttackActor = event:WaitForChild("eAttackActor")

local behavior = {
    id = "sword"
}

function behavior:create()
    local humanoid = self.character:FindFirstChild("Humanoid")
    if not humanoid then return end
    local slashAnimation = Animations.swing
    local backSlashAnimation = Animations.backswing

    self.swingTrack = humanoid:LoadAnimation(slashAnimation)
    self.backSwingTrack = humanoid:LoadAnimation(backSlashAnimation)
end

function behavior:activated(props)
    self.props = props
    local mouse = props.mouse
    if not self.doBackSwing then
        self.doBackSwing = true
        self.backSwingTrack:stop()
        self.swingTrack:play()
    else
        self.doBackSwing = false
        self.swingTrack:stop()
        self.backSwingTrack:play()
    end

    self.character.UpperTorso.BrickColor = BrickColor.new("Bright green")
end

function behavior:deactivated()
end

function behavior:updateProps(newProps)
    self.props = newProps
end

function behavior:update()
end

function behavior:equipped()
end

function behavior:unequipped()
end

function behavior:destroy()
end

return behavior