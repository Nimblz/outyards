-- an AI object holds a state machine used to direct NPC behavior
-- the AISystem attaches these to entities with AI components

local ai = script.Parent
local Controllers = require(ai:WaitForChild("Controllers"))

local AI = {}

local errors = {
    invalidAIType = "Invalid AI type [%s]"
}

function AI.new(entity, core, pzCore, aiType)
    assert(Controllers[aiType], errors.invalidAIType:format(aiType))
    return Controllers[aiType].new(entity,core,pzCore)
end

return AI