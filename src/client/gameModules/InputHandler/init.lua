local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Signal = require(lib:WaitForChild("Signal"))

local InputHandler = PizzaAlpaca.GameModule:extend("InputHandler")

local createInputSpec = require(script:WaitForChild("createInputSpec"))

local errors = {
    invalidActionError = "Action [%s] does not exist.",
    multipleSignalError = "Cannot create multiple signals for action [%s]. Did you accidentally define two?",
}

local stateMap = {
    [Enum.UserInputState.Begin] = "began",
    [Enum.UserInputState.Change] = "changed",
    [Enum.UserInputState.End] = "ended",
    [Enum.UserInputState.Cancel] = "canceled",
}

local INPUT_DEBUG_PRINTS = false

function InputHandler:create()
    self.actionSignals = {}
    self.actionBindings = {}
    self.inputSpec = createInputSpec()
    self.logger = nil
end

function InputHandler:preInit()

    self.logger = self.core:getModule("Logger"):createLogger(self)

    for name, actionSpec in pairs(self.inputSpec) do
        actionSpec.name = name
        self:createBindings(actionSpec)
        self:createActionSignal(name)
    end
end

function InputHandler:init()

end

function InputHandler:postInit()
    UserInputService.InputBegan:connect(function(input, robloxProcessed) self:onInput(input, robloxProcessed) end)
    UserInputService.InputChanged:connect(function(input, robloxProcessed) self:onInput(input, robloxProcessed) end)
    UserInputService.InputEnded:connect(function(input, robloxProcessed) self:onInput(input, robloxProcessed) end)
end

function InputHandler:getMousePos()
    return UserInputService:GetMouseLocation() - Vector2.new(0,GuiService:GetGuiInset().Y)
end

function InputHandler:onInput(input, robloxProcessed)
    -- find bindings that trigger on this input state
    -- do they match type and keycode?
    -- if so trigger their signals! :D

    if robloxProcessed then return end

    local inputType = input.UserInputType
    local keyCode = input.KeyCode

    for _, binding in pairs(self.actionBindings) do
        local inputDescription = binding.inputDescription
        local actionName = binding.actionName
        local typeValid = inputType == inputDescription.type
        local keyCodeValid = keyCode == inputDescription.keyCode or inputDescription.keyCode == nil

        if
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
    assert(not self.actionSignals[name], errors.multipleSignalError:format(name))

    local beganSignal = Signal.new()
    local changedSignal = Signal.new()
    local endedSignal = Signal.new()
    local canceledSignal = Signal.new()

    local binding = {
        began = beganSignal,
        changed = changedSignal,
        ended = endedSignal,
        canceled = canceledSignal,

        isActive = false,
    }

    beganSignal:connect(function()
        binding.isActive = true
    end)

    endedSignal:connect(function()
        binding.isActive = false
    end)

    canceledSignal:connect(function()
        binding.isActive = false
    end)

    self.actionSignals[name] = binding
end

-- Returns a signal object for the action name, returns nil and warns you if action does not exist
function InputHandler:getActionSignal(name)
    local signal = self.actionSignals[name]

    if not signal then warn(errors.invalidActionError:format(name)) end
    return signal
end

function InputHandler:fireActionSignal(name, input)
    local signalRoot = self.actionSignals[name]
    assert(signalRoot, errors.invalidActionError:format(name))
    local signal = signalRoot[stateMap[input.UserInputState]]
    assert(signal, errors.invalidActionError:format(name))

    if INPUT_DEBUG_PRINTS then
        self.logger:log(("Action [%s] fired!"):format(name))
        self.logger:log(
            "Action payload:\n"..
            "---- Position: "..tostring(input.Position).."\n"..
            "---- Delta: "..tostring(input.Delta).."\n"..
            "---- KeyCode: "..tostring(input.KeyCode).."\n"..
            "---- Type - State: "..tostring(input.UserInputType).." - "..tostring(input.UserInputState).."\n"
        )
    end
    signal:fire(input)
end



return InputHandler