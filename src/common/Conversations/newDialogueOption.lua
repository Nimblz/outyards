local dialogueOption_prototype = {
    text = "???",
    nextNode = nil, -- if nil this is the end of conversation.
    onSelect = function(self, player, server) end,
    getNextNode = function(self, player, server) return self.nextNode end,
}

local function newDialogueOption(props)
    return setmetatable(props,{__index = dialogueOption_prototype})
end

return newDialogueOption