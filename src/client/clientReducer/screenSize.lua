return function(state, action)

    if action.type == "SCREENSIZE_SET" then
        return action.screenSize
    end

    return state or Vector2.new(800,600)
end