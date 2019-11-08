-- grabbed from the rojo plugin: https://github.com/rojo-rbx/rojo/blob/master/plugin/src/Components/FitGrid.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local util = common.util

local Roact = require(lib.Roact)
local Dictionary = require(util.Dictionary)

local getAppliedScale = require(util.getAppliedScale)
local e = Roact.createElement

local FitGrid = Roact.PureComponent:extend("FitGrid")

function FitGrid:init()
	self.sizeBinding, self.setSize = Roact.createBinding(UDim2.new())
	self.layoutRef = Roact.createRef()
end

function FitGrid:refit(instance)
	local fitAxes = self.props.fitAxes or "Y"
	local minSize = self.props.minSize
	local containerProps = self.props.containerProps
	local paddingProps = self.props.paddingProps
	local sizeUpdated = self.props.sizeUpdated

	if paddingProps ~= nil then
		paddingProps = Dictionary.merge({
			PaddingTop = UDim.new(0,0),
			PaddingBottom = UDim.new(0,0),
			PaddingLeft = UDim.new(0,0),
			PaddingRight = UDim.new(0,0),
		}, paddingProps)
	end

	local scale = getAppliedScale(instance)
	local contentSize = instance.AbsoluteContentSize / scale

	if paddingProps ~= nil then
		contentSize = contentSize + Vector2.new(
			paddingProps.PaddingLeft.Offset + paddingProps.PaddingRight.Offset,
			paddingProps.PaddingTop.Offset + paddingProps.PaddingBottom.Offset
		)
	end

	if minSize then
		contentSize = Vector2.new(
			math.max(contentSize.X + 1, minSize.X),
			math.max(contentSize.Y + 1, minSize.Y)
		)
	end

	local combinedSize

	if fitAxes == "X" then
		combinedSize = UDim2.new(0, contentSize.X, containerProps.Size.Y.Scale, containerProps.Size.Y.Offset)
	elseif fitAxes == "Y" then
		combinedSize = UDim2.new(containerProps.Size.X.Scale, containerProps.Size.X.Offset, 0, contentSize.Y)
	-- elseif fitAxes == "XY" then
	-- 	combinedSize = UDim2.new(0, contentSize.X, 0, contentSize.Y)
	else
		error("Invalid fitAxes value")
	end

	self.setSize(combinedSize)

	if typeof(sizeUpdated) == "function" then
		sizeUpdated(combinedSize)
	end
end

function FitGrid:didMount()
	local instance = self.layoutRef:getValue()
	self:refit(instance)
end

function FitGrid:render()
	local containerKind = self.props.containerKind or "Frame"
	local containerProps = self.props.containerProps
	local layoutProps = self.props.layoutProps
	local paddingProps = self.props.paddingProps

	local padding
	if paddingProps ~= nil then
		paddingProps = Dictionary.merge({
			PaddingTop = UDim.new(0,0),
			PaddingBottom = UDim.new(0,0),
			PaddingLeft = UDim.new(0,0),
			PaddingRight = UDim.new(0,0),
		}, paddingProps)
		padding = e("UIPadding", paddingProps)
	end

	local children = Dictionary.merge(self.props[Roact.Children], {
		["$Layout"] = e("UIGridLayout", Dictionary.merge({
			SortOrder = Enum.SortOrder.LayoutOrder,
			[Roact.Change.AbsoluteContentSize] = function(instance)
				self:refit(instance)
			end,
			[Roact.Ref] = self.layoutRef
		}, layoutProps)),

		["$Padding"] = padding,
	})

	local fullContainerProps = Dictionary.merge(containerProps, {
		Size = self.sizeBinding,
	})

	return e(containerKind, fullContainerProps, children)
end

return FitGrid