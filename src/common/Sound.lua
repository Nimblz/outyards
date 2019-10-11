local Workspace = game:GetService("Workspace")

local soundBin = Instance.new("Folder")
soundBin.Name = "sounds"
soundBin.Parent = Workspace

local function newSound(props)
    local sound = Instance.new("Sound")

    sound.SoundId = props.soundId or ""
    sound.Volume = props.volume or 1
    sound.Pitch = props.pitch or 1

    sound.TimePosition = props.startTime or 0

    return sound
end

local function playSoundGlobal(props)
    local sound = newSound(props)
    sound.Parent = soundBin
    sound.Ended:connect(function()
        sound:Destroy()
    end)
    sound:Play()
end

local function playSoundAt(cFrame,props)
    local sound = newSound(props)
    local soundPart = Instance.new("Part")
    soundPart.Size = Vector3.new(1,1,1)
    soundPart.CFrame = cFrame
    soundPart.Anchored = true
    soundPart.CanCollide = false
    soundPart.Transparency = 1
    soundPart.Parent = soundBin

    sound.Parent = soundPart
    sound.Ended:connect(function()
        soundPart:Destroy()
    end)
    sound:Play()
end

return {
    presets = {
        gunshot = {
            soundId = "rbxassetid://154254953",
            volume = 0.33,
            pitch = 1.3,
        },
        slash = {
            soundId = "rbxassetid://12222216",
            volume = 0.5,
            pitch = 1,
            startTime = 0.3
        },
        hammer = {
            soundId = "rbxassetid://10730819",
            volume = 0.33,
            pitch = 1,
        },
        banned = {
            soundId = "rbxassetid://147722910",
            volume = 1,
            pitch = 1,
        },
        blargh = {
            soundId = "rbxassetid://138100175",
            volume = 1,
            pitch = 1,
        }
    },
    playSoundGlobal = playSoundGlobal,
    playSoundAt = playSoundAt,
    newSound = newSound,
}