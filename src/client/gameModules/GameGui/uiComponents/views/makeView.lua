local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local function makeView(component, viewId)
    -- wraps component in a new component that is only visible when its viewid is visible
    local newView = Roact.PureComponent:extend("view_"..viewId)

    function newView:render()
        return Roact.createElement("Frame", {
            Selectable = false,
            Active = false,
            BackgroundTransparency = 1,

            Visible = self.props.visible,
        })
    end

    local function mapStateToProps(state,props)
        return {
            visible = Selectors.getViewIdVisible(state,viewId)
        }
    end

    newView = RoactRodux.connect(mapStateToProps)(newView)

    return newView
end

return makeView