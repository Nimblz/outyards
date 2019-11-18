-- recieves component changed events for replication
local function createPlugin(addedEvent,changedEvent,removedEvent, getEntities)
    local subscriberPlugin = {}

    function subscriberPlugin:afterStepperStart(core)

        local allComponents = getEntities:InvokeServer()

        for _, componentEntity in ipairs(allComponents) do
            local entity = componentEntity.entity
            local components = componentEntity.components
            for className, componentProps in pairs(components) do
                if not entity then return end
                local componentIdentifier = core:getComponentClass(className)
                if componentIdentifier then
                    core:addComponent(entity, componentIdentifier, componentProps)
                end
            end
        end

        addedEvent.OnClientEvent:connect(function(instance, className, props)
            if not instance then return end
            local componentIdentifier = core:getComponentClass(className)
            if componentIdentifier then
                core:addComponent(instance, componentIdentifier, props)
            end
        end)

        changedEvent.OnClientEvent:connect(function(instance, className, key, newValue)
            if not instance then return end
            local componentIdentifier = core:getComponentClass(className)
            local component = core:getComponent(instance,componentIdentifier)
            if component then
                component:updateProperty(key,newValue)
            end
        end)

        removedEvent.OnClientEvent:connect(function(instance, className)
            if not instance then return end
            local componentIdentifier = core:getComponentClass(className)
            if core:getComponent(instance,componentIdentifier) then
                core:removeComponent(instance, componentIdentifier)
            end
        end)
    end

    return subscriberPlugin
end

return createPlugin