
--[[--------------------------------------------------
little juiceModel module, by bigbadbob234
----------------------------------------------------]]
local RunService = game:getService("RunService")
local TweenService = game:getService("TweenService")

local jIdByModel = {}
local jPartColors = {}

local function flashModel(model, color, sustain, time)--{{{
    color = color or Color3.new(1,1,1)
    sustain = sustain or 0.1
    time = time or 0.2
    --> settings setup
    local tinfo = TweenInfo.new(0,1,1)

    --> state setup
    local theseParts = {}
    local oldJuiceId = jIdByModel[model] or 0
    local newJuiceId = oldJuiceId+1
    jIdByModel[model] = newJuiceId

    --> instant-tween back to juice-color
    for _,child in pairs(model:GetDescendants()) do
        if child:IsA"BasePart" then
            table.insert(theseParts, child)
            if not jPartColors[child] then
                jPartColors[child] = child.Color
            end

            child.Color = color
            local twn = TweenService:Create(child, tinfo, {Color = color})
            twn:Play()
        end
    end

    --> tween colors back after a moment
    coroutine.wrap(function()
        wait(sustain)
        local returnTweenInfo = TweenInfo.new(time,1,1)
        for _,part in pairs(theseParts) do
            local twn = TweenService:Create(part, returnTweenInfo, {Color = jPartColors[part]})
            twn:Play()
        end
        wait(time)

        --> check and clean up state if it's the most recent juice,
        if jIdByModel[model] == newJuiceId then
            jIdByModel[model] = nil
            for _,part in pairs(theseParts) do
                part.Color = jPartColors[part]
                jPartColors[part] = nil
            end
        end

    end)()
end

return flashModel