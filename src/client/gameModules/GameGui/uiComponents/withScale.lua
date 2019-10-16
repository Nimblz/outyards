local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

local Camera = Workspace.CurrentCamera
local TopInset, BottomInset = GuiService:GetGuiInset()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local Scale = Roact.Component:extend("Scale")

local function round(x,increment)
    return math.floor((x/increment) + 0.5)*increment
end

function Scale:init()
	self:update()

	self.Listener = Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		self:update()
    end)

    self._context.getScale = function()
        return self.state.scale
    end
end

function Scale:update()
    local defaultSize = self.props.defaultSize
    local minScale = self.props.minScale
    local maxScale = self.props.maxScale
	local viewportSize = Camera.ViewportSize - (TopInset + BottomInset)
    local scaleIncrement = self.props.scaleIncrement

    local xScale = round(viewportSize.X / defaultSize.X, scaleIncrement)
    local yScale = round(viewportSize.Y / defaultSize.Y, scaleIncrement)

	self:setState({
		scale = math.clamp(math.min(xScale, yScale), minScale, maxScale)
    })
end

function Scale:willUnmount()
	self.Listener:Disconnect()
end

function Scale:render()
	local scaleElement = Roact.createElement("UIScale", {
		Scale = self.state.scale * self.props.scale
    })
    local children = self.props[Roact.Children]

    local joinedChildren = Dictionary.join(children,{["$Scale"] = scaleElement})

    return Roact.createFragment(joinedChildren)
end

Scale.defaultProps = {
    defaultSize = Vector2.new(1280,800),
    scale = 1,
    minScale = 0.5,
    maxScale = 1,
    scaleIncrement = 0.5,
}

local function withScale(component)
    local newScaled = Roact.Component:extend("ScaledComponent")

    function newScaled:render()
        local children = self.props[Roact.Children]

        local prunedProps = Dictionary.join(self.props, {
            [Roact.Children] = Dictionary.None,
        })

        return Roact.createElement(component, prunedProps, {
            Roact.createElement(Scale, Scale.defaultProps, children)
        })
    end

    return newScaled
end

return withScale