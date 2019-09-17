local function getDiffs(t1,t2)
    local added, removed = {}, {}
    local t1Set, t2Set = {}, {}

    -- create t1 hash set
    for _,v in pairs(t1) do
        t1Set[v] = true
    end
    -- create t2 hash set and check against t1 set to find new elements
    for _,v in pairs(t2) do
        t2Set[v] = true
        -- do this here to cut out an extra for loop
        if not t1Set[v] then
            table.insert(added,v)
        end
    end
    -- check t1 against t2 set to find removed
    for _,v in pairs(t1) do
        if not t2Set[v] then
            table.insert(removed,v)
        end
    end

    return added,removed
end

return getDiffs