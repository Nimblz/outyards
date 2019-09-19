-- trying to make an ergonomic state machine
-- maybe im just making madness

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local Signal = require(lib:WaitForChild("Signal"))

local FSM = {}

function FSM.new(states,startState)
    local self = setmetatable({},{__index=FSM})

    self.states = states

    -- name states
    for name,state in pairs(self.states) do
        state.name = name
    end

    self.enteringState = Signal.new()
    self.leavingState = Signal.new()

    self:transition(startState)

    return self
end

function FSM:transition(newState, ...)
    if not newState then return end

    if self.currentState and typeof(self.currentState.leaving) == "function" then
        self.leavingState:fire(self.currentState.name)
        self.currentState.leaving()
    end

    local targetState = self.states[newState]
    self.currentState = targetState

    self.enteringState:fire(self.currentState.name)
    return self:transition(targetState.enter(...))
end

function FSM:step(...)
    if not self.currentState.step then return end
    if not typeof(self.currentState.step) == "function" then return end

    self:transition(self.currentState.step(...))
end

return FSM