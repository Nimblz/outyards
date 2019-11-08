local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

local Camera = Workspace.CurrentCamera
local TopInset, BottomInset = GuiService:GetGuiInset()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)

local ScreenScaler = Roact.PureComponent:extend("ScreenScaler")

local function round(x,increment)
    return math.floor((x/increment) + 0.5)*increment
end

function ScreenScaler:init()
	self:update()

	self.Listener = Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		self:update()
    end)

    self._context.getScale = function()
        return self.state.scale
    end
end

function ScreenScaler:update()
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

function ScreenScaler:willUnmount()
	self.Listener:Disconnect()
end

function ScreenScaler:render()
	return Roact.createElement("UIScale", {
		Scale = self.state.scale * self.props.scale
    })
end

ScreenScaler.defaultProps = {
    defaultSize = Vector2.new(1280,800),
    scale = 1,
    minScale = 0.5,
    maxScale = 1,
    scaleIncrement = 0.25,
}

return ScreenScaler