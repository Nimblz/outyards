-- an AI object holds a state machine used to direct NPC behavior
-- the AISystem attaches these to entities with AI components

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local StateMachine = require(lib:WaitForChild("StateMachine"))

local ai = script.Parent
local AITypes = require(ai:WaitForChild("AITypes"))

local AI = {}

local errors = {
    invalidAIType = "Invalid AI type [%s]"
}

function AI.new(core,typeName)
    local self = setmetatable({__index = AI})

    self.type = AITypes[typeName]
    assert(self.type, errors.invalidAIType:format(tostring(type)))

    self.state = StateMachine.create(self.type)

    return self
end

return AI