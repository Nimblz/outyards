local dialogueOption_prototype = {
    text = "RESPONSE UNIMPLEMENTED, NOTIFY NIMBLZ",
    onSelect = function(player, server) end,
    nextNode = nil, -- if nil this is the end of conversation.
}

local function newDialogueOption(props)
    return setmetatable(props,{__index = dialogueOption_prototype})
end

return newDialogueOption