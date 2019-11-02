-- broadcasts component changed events for replication

local blacklist = {
    changed = true,
    raisePropertyChanged = true,
    className = true,
    entityFilter = true,
    __index = true,
}

local function toNetworkable(component)
    local className = component.className
    local networkedComponent = {}
    for key, value in pairs(component) do
        if not blacklist[key] and typeof(value) ~= "function" then
            networkedComponent[key] = value
        end
    end

    return className, networkedComponent
end

local function createPlugin(addedEvent, changedEvent, removedEvent, initialEvent, playerAddedSignal)
    local broadcastPlugin = {}

    function broadcastPlugin:componentAdded(core, instance, component)
        if not component.replicates then return end
        local className, networkedComponent = toNetworkable(component)

        addedEvent:FireAllClients(instance, className, networkedComponent)
        component.changed:connect(function(key, newValue, oldValue)
            changedEvent:FireAllClients(instance, className, key, newValue)
        end)
    end

    function broadcastPlugin:componentRemoving(core, instance,component)
        if not component.replicates then return end
        removedEvent:FireAllClients(instance,component.className)
    end

    function broadcastPlugin:coreInit(core)
        local Players = game:GetService("Players")

        local function playerAdded(newPlayer)
            -- for each entity, replicate its components x-x (is this too much?)
            local allComponents = {}
            for _, entityPairs in pairs(core._components) do
                for entity, component in pairs(entityPairs) do
                    local newEntity = {
						entity = entity,
						components = {},
					}
                    if component.replicates then
                        local className, networkedComponent = toNetworkable(component)
                        newEntity.components[className] = networkedComponent
                    end
					table.insert(allComponents, newEntity)
                end
            end

            initialEvent:FireClient(newPlayer, allComponents)
        end

        playerAddedSignal:connect(playerAdded)

        for _, player in pairs(Players:GetPlayers()) do
            playerAdded(player)
        end
    end

    return broadcastPlugin
end

return createPlugin