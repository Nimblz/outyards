-- grabbed from the rojo plugin: https://github.com/rojo-rbx/rojo/blob/master/plugin/src/Components/FitText.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local e = Roact.createElement

local FitText = Roact.Component:extend("FitText")

function FitText:init()
	self.ref = Roact.createRef()
	self.sizeBinding, self.setSize = Roact.createBinding(UDim2.new())
end

function FitText:render()
    local kind = self.props.kind or "TextLabel"

	local containerProps = Dictionary.merge(self.props, {
		fitAxis = Dictionary.None,
		kind = Dictionary.None,
		padding = Dictionary.None,
        minSize = Dictionary.None,
        scale = Dictionary.None,
		Size = self.sizeBinding,
		[Roact.Ref] = self.ref,
		[Roact.Change.AbsoluteSize] = function()
			self:updateTextMeasurements()
		end
	})

	return e(kind, containerProps)
end

function FitText:didMount()
	self:updateTextMeasurements()
end

function FitText:didUpdate()
	self:updateTextMeasurements()
end

function FitText:updateTextMeasurements()
	local minSize = self.props.minSize or Vector2.new(0, 0)
	local padding = self.props.padding or Vector2.new(0, 0)
	local scale = self.props.scale or 1
	local fitAxis = self.props.fitAxis or "XY"
	local baseSize = self.props.Size

	local text = self.props.Text or ""
	local font = self.props.Font or Enum.Font.Legacy
	local textSize = self.props.TextSize or 12

	local containerSize = self.ref.current.AbsoluteSize

	local textBounds

	if fitAxis == "XY" then
		textBounds = Vector2.new(9e6, 9e6)
	elseif fitAxis == "X" then
		textBounds = Vector2.new(9e6, containerSize.Y - padding.Y * 2)
	elseif fitAxis == "Y" then
		textBounds = Vector2.new(containerSize.X - padding.X * 2, 9e6)
	end

	local measuredText = TextService:GetTextSize(text, textSize, font, textBounds) / scale

	local computedX = math.max(minSize.X, padding.X * 2 + measuredText.X)
	local computedY = math.max(minSize.Y, padding.Y * 2 + measuredText.Y)

	local totalSize

	if fitAxis == "XY" then
		totalSize = UDim2.new(
			0, computedX,
			0, computedY)
	elseif fitAxis == "X" then
		totalSize = UDim2.new(
			0, computedX,
			baseSize.Y.Scale, baseSize.Y.Offset)
	elseif fitAxis == "Y" then
		totalSize = UDim2.new(
			baseSize.X.Scale, baseSize.X.Offset,
			0, computedY)
	end

	self.setSize(totalSize)
end

return FitText