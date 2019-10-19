-- function that returns true if table contains a value

return function(table, toFind)
    assert(typeof(table) == "table", "Argument 1 must be a table!")

    for _, value in pairs(table) do
        if value == toFind then
            return true
        end
    end
    return false
end