local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local withScale = require(component.withScale)

local function makeView(kind, viewId)
    -- wraps component in a new component that is only visible when its viewid is visible
    local newView = Roact.Component:extend("view_"..viewId)

    local componentWithScale = withScale(kind)

    function newView:render()

        return Roact.createElement("Frame", {
            Selectable = false,
            Active = false,
            BackgroundTransparency = 1,

            Size = UDim2.new(1,0,1,0),
            ZIndex = 2,
            Visible = self.props.visible,
        }, {
            view = Roact.createElement(componentWithScale, self.props)
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