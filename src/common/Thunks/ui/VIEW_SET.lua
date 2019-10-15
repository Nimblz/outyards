local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Actions = require(common:WaitForChild("Actions"))

local emptyView = {
    VIEW_NAVBAR_SETVISIBLE = false,
    VIEW_HEALTHBAR_SETVISIBLE = false,
    VIEW_TOOLBAR_SETVISIBLE = false,
    VIEW_BOOSTS_SETVISIBLE = false,
    VIEW_CRAFTING_SETVISIBLE = false,
    VIEW_INVENTORY_SETVISIBLE = false,
    VIEW_CODES_SETVISIBLE = false,
    VIEW_OPTIONS_SETVISIBLE = false,
}

local views = {
    default = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_HEALTHBAR_SETVISIBLE = true,
        VIEW_TOOLBAR_SETVISIBLE = true,
    },
    boosts = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_BOOSTS_SETVISIBLE = true,
    },
    crafting = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_HEALTHBAR_SETVISIBLE = true,
        VIEW_TOOLBAR_SETVISIBLE = true,
        VIEW_CRAFTING_SETVISIBLE = true,
    },
    inventory = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_HEALTHBAR_SETVISIBLE = true,
        VIEW_TOOLBAR_SETVISIBLE = true,
        VIEW_INVENTORY_SETVISIBLE = true,
    },
    codes = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_CODES_SETVISIBLE = true,
    },
    options = {
        VIEW_NAVBAR_SETVISIBLE = true,
        VIEW_OPTIONS_SETVISIBLE = true,
    },
}

return function(viewId)
    return function(store)
        local viewDescription = views[viewId]
        -- reset ui to base state
        for actionKey, _ in pairs(emptyView) do
            local actionCreator = Actions[actionKey]
            if actionCreator then
                store:dispatch(actionCreator(false))
            end
        end
        -- set our elements for this view to visible
        for actionKey, isVisible in pairs(viewDescription) do
            local actionCreator = Actions[actionKey]
            if actionCreator then
                store:dispatch(actionCreator(isVisible))
            end
        end

        store:dispatch(Actions.VIEW_SET(viewId))
    end
end