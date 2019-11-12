local conversation_prototype = {
    speakerName = "N/A",
    rootNode = nil,
    currentNode = nil,
}

local function newConversation(props)
    return setmetatable(props,{__index = conversation_prototype})
end

return newConversation