local FSM = {}

function FSM.new(states,startState)
    local self = setmetatable({},{__index=FSM})

    local stateStack = {states[startState]}
    self.states = states

    return self
end

function FSM:dispatch(...)
    self.stateStack[#self.stateStack](...)
end