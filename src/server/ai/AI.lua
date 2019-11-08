-- an AI object holds a state machine used to direct NPC behavior
-- the AISystem attaches these to entities with AI components

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util
local lib = ReplicatedStorage.lib
local ai = script.Parent
--local event = ReplicatedStorage.event

local FSM = require(util.FSM)
local Controllers = require(ai.Controllers)

local AI = {}

local errors = {
    invalidAIType = "Invalid AI type [%s] are you sure a controller exists?"
}

function AI.new(entity, core, pzCore, aiType)
    local controllerName = "new"..aiType
    assert(Controllers[controllerName], errors.invalidAIType:format(aiType))

    local states = Controllers[controllerName](entity, core, pzCore)
    local fsm = FSM.new(states,"awake")

    local newAI = {
        fsm = fsm,
        type = aiType,
        entity = entity,
        enteringState = fsm.enteringState
    }

    setmetatable(newAI,{__index = AI})

    return newAI
end

function AI:step()
    self.fsm:step()
end

function AI:kill()
    self.fsm.deadLocked = true
    self.fsm:_transition("dead")
    self.fsm = nil
    self.entity = nil
    self.type = nil
end

return AI