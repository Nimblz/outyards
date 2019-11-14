local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local dialogueEvent = event.dialogue

local Conversations = require(common.Conversations)
local Signal = require(lib.Signal)

local PizzaAlpaca = require(lib.PizzaAlpaca)

local eDialogueClosed = dialogueEvent.eDialogueClosed
local eDialogueChanged = dialogueEvent.eDialogueChanged
local eOptionSelected = dialogueEvent.eOptionSelected

local Dialogue = PizzaAlpaca.GameModule:extend("Dialogue")

local function canPlayerTalk(player)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local humanoidState = humanoid:GetState()
            return humanoidState ~= Enum.HumanoidStateType.Dead
        end
    end

    return false
end

function Dialogue:canPlayerStartConversation(player)
    local canTalk = canPlayerTalk(player)
    if canTalk then
        return self.conversations[player] == nil
    end
end

function Dialogue:create()
    self.conversations = {}
    self.conversationClosed = Signal.new()
    self.conversationStarted = Signal.new()
    self.conversationTransitioned = Signal.new()
    -- playerConversations[player] = activeConversation
    -- if no conversation is taking place then players index will be nil
end

function Dialogue:transitionConversation(player,newNode)
    local conversation = self.conversations[player]

    if conversation then
        conversation.currentNode = newNode
    end

    -- convert options objects to strings
    -- client doesnt need to know about structure, only text and options.
    local optionsStrings = {}
    for _, option in ipairs(newNode.options or {}) do
        table.insert(optionsStrings, option.text)
    end


    local newText = newNode.text

    local props = {
        speaker = conversation.speaker,
        text = newText,
        options = optionsStrings,
    }

    eDialogueChanged:FireClient(player, props)
    self.conversationTransitioned:fire(player, props)
    newNode.onEnter(player, self.core)
end

function Dialogue:optionSelected(player, optionIndex)
    -- if the player is in a conversation
    -- if the conversation has an option at that index
    -- move conversation to that options node and fire changed event

    local conversation = self.conversations[player]

    if conversation then
        local currentNode = conversation.currentNode
        if currentNode then
            local option = currentNode.options[optionIndex]
            if option then
                -- move convo to that node
                option.onSelect(player, self.core)
                if option.nextNode then
                    self:transitionConversation(player, option.nextNode)
                else
                    self:closeConversation(player)
                end
            end
        else
            self:closeConversation(player)
        end
    end
end

function Dialogue:closeConversation(player)
    if self.conversations[player] ~= nil then
        self.conversationClosed:fire(player)
        eDialogueClosed:FireClient(player)
        self.conversations[player] = nil
    end
end

function Dialogue:startConversation(player, id)
    -- create a new conversation session for player

    -- things that should destroy the conversation
        -- player walking away (done)
        -- player dying (done)
        -- player leaving (done)
        -- player closing the conversation (done)

    local conversationDescription = Conversations.byId[id]

    if self:canPlayerStartConversation(player) and conversationDescription then
        local newConvo = conversationDescription.create(self.core, player)

        self.conversations[player] = newConvo
        self.conversationStarted:fire(player, id)
        self:transitionConversation(player, newConvo.rootNode)

        -- everything inside of this coroutine is pure evil
        -- reader beware ur in for a scare!
        -- this handles force closing the conversation if the player walks away
        if conversationDescription.closeOnWalkAway then
            coroutine.wrap(function()
                local startPos = player.Character.PrimaryPart.Position
                local convoMaxDist = 20
                local convoClosed = false

                local connection
                connection = self.conversationClosed:connect(function(closedPlayer)
                    if closedPlayer == player then
                        connection:disconnect()
                        convoClosed = true
                    end
                end)

                local function closeEnough()
                    if not canPlayerTalk(player) then return false end
                    local currentPos = player.Character.PrimaryPart.Position
                    return (currentPos - startPos).magnitude < convoMaxDist
                end

                while closeEnough() do
                    wait(1/5)
                end

                if not convoClosed then
                    self:closeConversation(player)
                end
            end)()
        end
    end
end

function Dialogue:postInit()
    Players.PlayerRemoving:connect(function(player)
        self:closeConversation(player)
    end)

    Players.PlayerAdded:connect(function(player)
        player.CharacterAdded:connect(function(newCharacter)
            local humanoid = newCharacter:WaitForChild("Humanoid")

            humanoid.Died:connect(function() -- death always ends conversations
                self:closeConversation(player)
            end)
        end)
    end)

    eDialogueClosed.OnServerEvent:connect(function(player)
        self:closeConversation(player)
    end)

    eOptionSelected.OnServerEvent:connect(function(player, optionIndex)
        optionIndex = optionIndex or 1
        assert(typeof(optionIndex) == "number")
        self:optionSelected(player, optionIndex)
    end)
end

return Dialogue