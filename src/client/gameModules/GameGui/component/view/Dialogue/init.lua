local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local view = script:FindFirstAncestor("view")

local eDialogueChanged = event.dialogue.eDialogueChanged
local eOptionSelected = event.dialogue.eOptionSelected
local eDialogueClosed = event.dialogue.eDialogueClosed

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Thunks = require(common.Thunks)
local Actions = require(common.Actions)

local makeView = require(view.makeView)

local ResponseOptions = require(script.ResponseOptions)
local SpeechBubble = require(script.SpeechBubble)

local Dialogue = Roact.PureComponent:extend("Dialogue")

function Dialogue:init(initialProps)
    self:setState({
        speaker = "???",
        text = "Nothing is said.",
        options = {},
    })

    eDialogueChanged.OnClientEvent:connect(function(speechProps)
        self.props.startDialogue()
        self:setState(function()
            return {
                speaker = speechProps.speaker,
                text = speechProps.text,
                options = speechProps.options,
            }
        end)
    end)

    eDialogueClosed.OnClientEvent:connect(function(arg)
        self.props.closeDialogue()
    end)
end

function Dialogue:didMount()
end

function Dialogue:render()
    local speaker = self.state.speaker
    local text = self.state.text
    local options = self.state.options

    local layout = Roact.createElement("UIListLayout", {
        Padding = UDim.new(0,8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,1),
        Position = UDim2.new(0.5,0,1,-200),
        Size = UDim2.new(0,600,0,150),
    }, {
        layout = layout,
        options = Roact.createElement(ResponseOptions, {
            options = options,
            optionSelected = function(index)
                eOptionSelected:FireServer(index)
            end,
            closeSelected = function()
                eDialogueClosed:FireServer()
            end,
        }), --optionsFrame,
        speech = Roact.createElement(SpeechBubble, {
            speaker = speaker, text = text
        }),--speechFrame,
    })
end

local function mapDispatchToProps(dispatch)
    return {
        startDialogue = function()
            dispatch(Thunks.VIEW_SET("dialogue"))
            dispatch(Actions.CANINTERACT_SET(false))
        end,
        closeDialogue = function()
            dispatch(Thunks.VIEW_SET("default"))
            dispatch(Actions.CANINTERACT_SET(true))
        end
    }
end

Dialogue = makeView(Dialogue, "dialogue")
Dialogue = RoactRodux.connect(nil,mapDispatchToProps)(Dialogue)

return Dialogue