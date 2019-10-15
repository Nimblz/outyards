local function getDiffs(before,after)
    local added, removed = {}, {}
    local beforeSet, afterSet = {}, {}

    -- create before hash set
    for _,v in pairs(before) do
        beforeSet[v] = true
    end
    -- create after hash set and check against before set to find new elements
    for _,v in pairs(after) do
        afterSet[v] = true
        -- do this here to cut out an extra for loop
        if not beforeSet[v] then
            table.insert(added,v)
        end
    end
    -- check before against after set to find removed
    for _,v in pairs(before) do
        if not afterSet[v] then
            table.insert(removed,v)
        end
    end

    return added,removed
end

return getDiffs