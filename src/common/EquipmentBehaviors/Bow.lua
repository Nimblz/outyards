local behavior = {
    id = "bow"
}

function behavior:create()
end

function behavior:activated(props)
    self.props = props
    -- props contains things like target direction, and any other metadata involved with activation
end

function behavior:deactivated()
end

function behavior:updateProps(newProps)
    self.props = newProps
end

function behavior:update()
end

function behavior:equipped()
end

function behavior:unequipped()
end

function behavior:destroy()
end

return behavior