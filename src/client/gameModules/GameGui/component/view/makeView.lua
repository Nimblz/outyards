local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util
local component = script:FindFirstAncestor("component")

local Dictionary = require(util.Dictionary)
local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local withScale = require(component.withScale)

local function makeView(component, viewId)
    -- wraps component in a new component that is only visible when its viewid is visible
    local newView = Roact.Component:extend("view_"..viewId)

    local componentWithScale = withScale(component, {
        defaultSize = Vector2.new(1280,800),
        scale = 1,
        minScale = 0.5,
        maxScale = 1,
        scaleIncrement = 0.25,
    })

    function newView:render()

        local prunedProps = Dictionary.join(self.props, {
            visible = Dictionary.None,
        })

        return self.props.visible and Roact.createElement("Frame", {
            Selectable = false,
            Active = false,
            BackgroundTransparency = 1,

            Size = UDim2.new(1,0,1,0),
            ZIndex = 2,
            Visible = self.props.visible,
        }, {
            view = Roact.createElement(componentWithScale, prunedProps)
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