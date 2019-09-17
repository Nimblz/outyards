local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Signal = require(lib:WaitForChild("Signal"))

local InputHandler = PizzaAlpaca.GameModule:extend("InputHandler")

local createInputSpec = require(script:WaitForChild("createInputSpec"))

function InputHandler:create()
    self.actionSignals = {}
    self.actionBindings = {}
    self.inputSpec = createInputSpec()
    self.logger = nil
end

function InputHandler:preInit()

    self.logger = self.core:getModule("Logger"):createLogger(self)

    for name, actionSpec in pairs(self.inputSpec) do
        print("Binding for action:",name)
        actionSpec.name = name
        self:createBindings(actionSpec)
        self:createActionSignal(name)
    end
end

function InputHandler:init()

end

function InputHandler:postInit()
    UserInputService.InputBegan:connect(function(input) self:onInput(input) end)
    UserInputService.InputChanged:connect(function(input) self:onInput(input) end)
    UserInputService.InputEnded:connect(function(input) self:onInput(input) end)
end

function InputHandler:onInput(input, robloxProcessed)
    -- find bindings that trigger on this input state
    -- do they match type and keycode?
    -- if so trigger their signals! :D

    if robloxProcessed then return end

    local inputState = input.UserInputState
    local inputType = input.UserInputType
    local keyCode = input.KeyCode

    for _, binding in pairs(self.actionBindings) do
        local inputDescription = binding.inputDescription
        local actionName = binding.actionName

        local stateValid = inputState == inputDescription.state
        local typeValid = inputType == inputDescription.type
        local keyCodeValid = keyCode == inputDescription.keyCode or inputDescription.keyCode == nil

        if
            stateValid and
            typeValid and
            keyCodeValid
        then
            self:fireActionSignal(actionName, input)
        end

    end
end

function InputHandler:createBindings(actionSpec)
    for _, inputDescription in pairs(actionSpec.inputs) do
        local newBinding = {}

        newBinding.inputDescription = inputDescription
        newBinding.actionName = actionSpec.name

        table.insert(self.actionBindings, newBinding)
    end
end

function InputHandler:createActionSignal(name)
    assert(not self.actionSignals[name],
        "Cannot create multiple signals for action ["..name.."]. Did you accidentally define two?")

    local newSignal = Signal.new()

    self.actionSignals[name] = newSignal
end

-- Returns a signal object for the action name, returns nil and warns you if action does not exist
function InputHandler:getActionSignal(name)
    local signal = self.actionSignals[name]

    if not signal then warn("No signal for action: "..name) end
    return signal
end

function InputHandler:fireActionSignal(name, input)
    local signal = self.actionSignals[name]

    assert(signal, "No signal for action: "..name)

    if self.core._debugPrints then
        self.logger:log(("Action %s fired!"):format(name))
    end
    signal:fire(input)
end



return InputHandler