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
            volume = 0.5,
            pitch = 1.0,
        },
        gunshot_2 = {
            soundId = "rbxassetid://97852331",
            volume = 1.0,
            pitch = 1.0,
        },
        gunshot_3 = {
            soundId = "rbxassetid://2697431",
            volume = 1.0,
            pitch = 1.0,
        },
        gunshot_light = {
            soundId = "rbxassetid://95309366",
            volume = 1.0,
            pitch = 1.0,
        },
        gunshot_sniper = {
            soundId = "rbxassetid://2697294",
            volume = 1.0,
            pitch = 1.0,
        },
        gunshot_heavy = {
            soundId = "rbxassetid://2760979",
            volume = 1.0,
            pitch = 1.0,
        },
        gunshot_rifle = {
            soundId = "rbxassetid://94125590",
            volume = 1.0,
            pitch = 1.0,
        },
        paintballshot_light = {
            soundId = "rbxassetid://27127089",
            volume = 1.0,
            pitch = 1.0,
        },
        paintballshot_heavy = {
            soundId = "rbxassetid://11900833",
            volume = 1.0,
            pitch = 1.0,
        },
        rocketshot = {
            soundId = "rbxassetid://81116734",
            volume = 1.0,
            pitch = 1.0,
        },
        laser = {
            soundId = "rbxassetid://65069831",
            volume = 1.0,
            pitch = 1.0,
        },
        laser_2 = {
            soundId = "rbxassetid://88517571",
            volume = 1.0,
            pitch = 1.5,
        },
        laser_3 = {
            soundId = "rbxassetid://90655239",
            volume = 1.0,
            pitch = 1.0,
        },
        laser_light = {
            soundId = "rbxassetid://32645452",
            volume = 1.0,
            pitch = 1.0,
        },
        railgun = {
            soundId = "rbxassetid://81116761",
            volume = 1.0,
            pitch = 1.0,
        },
        magicburst = {
            soundId = "rbxassetid://101157919",
            volume = 1.0,
            pitch = 1.0,
        },
        heal_spell = {
            soundId = "rbxassetid://2101144",
            volume = 1.0,
            pitch = 1.0,
        },
        slash = {
            soundId = "rbxassetid://28166555",
            volume = 0.5,
            pitch = 1,
        },
        classic_slash = {
            soundId = "rbxassetid://12222216",
            volume = 0.5,
            pitch = 1,
            startTime = 0.3
        },
        classic_lunge = {
            soundId = "rbxassetid://12222208",
            volume = 0.5,
            pitch = 1,
        },
        classic_sword_equip = {
            soundId = "rbxassetid://12222225",
            volume = 0.5,
            pitch = 1,
        },
        hammer = {
            soundId = "rbxassetid://10730819",
            volume = 0.33,
            pitch = 1,
        },
        katana_slash = {
            soundId = "rbxassetid://45885030",
            volume = 1.0,
            pitch = 1.0,
        },
        banned = {
            soundId = "rbxassetid://147722910",
            volume = 1.0,
            pitch = 1.0,
        },
        blargh = {
            soundId = "rbxassetid://138100175",
            volume = 1.0,
            pitch = 1.0,
        },
        crossbow_shoot = {
            soundId = "rbxassetid://16211041",
            volume = 1.0,
            pitch = 1.0,
        },
        classic_slingshot = {
            soundId = "rbxassetid://12222106",
            volume = 1.0,
            pitch = 1.0,
            startTime = 0.1,
        },
        arrow_hit = {
            soundId = "rbxassetid://13460996",
            volume = 1.5,
            pitch = 1.0,
        },
        explosion_massive = {
            soundId = "rbxassetid://3087031",
            volume = 1.0,
            pitch = 1.0,
        },
        explosion_1 = {
            soundId = "rbxassetid://2233908",
            volume = 1.0,
            pitch = 1.0,
        },
        light_impact = {
            soundId = "rbxassetid://108553933",
            volume = 1.0,
            pitch = 1.0,
        },
        reload_heavy = {
            soundId = "rbxassetid://97094986",
            volume = 1.0,
            pitch = 1.0,
        },
        reload_pistol = {
            soundId = "rbxassetid://2920960",
            volume = 1.0,
            pitch = 1.0,
        },
        duck = {
            soundId = "rbxassetid://9413306",
            volume = 1.0,
            pitch = 1.0,
        },
        squeakytoy = {
            soundId = "rbxassetid://84902413",
            volume = 1.0,
            pitch = 1.0,
        },
        playerdeath = {
            soundId = "rbxassetid://88755860",
            volume = 1.0,
            pitch = 1.0,
        },
        criticalhit = {
            soundId = "rbxassetid://54516144",
            volume = 1.0,
            pitch = 1.0,
        },
        pop_1 = {
            soundId = "rbxassetid://96997821",
            volume = 1.0,
            pitch = 1.0,
        },
        pop_2 = {
            soundId = "rbxassetid://96997831",
            volume = 1.0,
            pitch = 1.0,
        },
    },
    playSoundGlobal = playSoundGlobal,
    playSoundAt = playSoundAt,
    newSound = newSound,
}