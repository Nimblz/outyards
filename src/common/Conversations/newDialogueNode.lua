local dialogueNode_prototype = {
    text = "* This person is speaking a language you do not understand\n* You decide it's best to leave",
    responseOptions = {},
    onEnter = function(self, player, server) end,
}

local function newDialogueNode(props)
    return setmetatable(props,{__index = dialogueNode_prototype})
end

return newDialogueNode