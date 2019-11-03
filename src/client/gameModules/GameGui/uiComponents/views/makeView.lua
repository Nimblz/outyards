local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local function makeView(component, viewId)
    -- wraps component in a new component that is only visible when its viewid is visible
    local newView = Roact.Component:extend("view_"..viewId)

    function newView:render()

        local prunedProps = Dictionary.join(self.props, {
            visible = Dictionary.None,
        })

        return Roact.createElement("Frame", {
            Selectable = false,
            Active = false,
            BackgroundTransparency = 1,

            Size = UDim2.new(1,0,1,0),
            ZIndex = 2,

            Visible = self.props.visible or false,
        }, {
            view = Roact.createElement(component, prunedProps)
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