local function notifAdd(state, action)
    local newNotifs = {byId = {}, all = {}}

    for id, notif in pairs(state.byId) do
        newNotifs.byId[id] = notif
    end

    for idx, id in ipairs(state.all) do
        newNotifs.all[idx] = id
    end

    newNotifs.byId[action.id] = action.props

    table.insert(newNotifs.all, 1, action.id) -- push to front

    return newNotifs
end

local function notifRemove(state, action)
    local newNotifs = {byId = {}, all = {}}

    for id, notif in pairs(state.byId) do
        if id ~= action.id then
            newNotifs.byId[id] = notif
        end
    end

    for _,id in ipairs(state.all) do
        if id ~= action.id then
            table.insert(newNotifs.all,id)
        end
    end

    return newNotifs
end

return function(state, action)
    state = state or {byId = {}, all = {}}

    if action.type == "NOTIFICATION_ADD" then
        return notifAdd(state, action)
    elseif action.type == "NOTIFICATION_REMOVE" then
        return notifRemove(state, action)
    end
    return state
end