local dialogueNode_prototype = {
    text = "NODE TEXT UNIMPLEMENTED, NOTIFY NIMBLZ PLEASE",
    onEnter = function(player, server) end,
    responseOptions = {},
}

local function newDialogueNode(props)
    return setmetatable(props,{__index = dialogueNode_prototype})
end

return newDialogueNode