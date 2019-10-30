-- grabbed from the rojo plugin: https://github.com/rojo-rbx/rojo/blob/master/plugin/src/Components/FitList.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local getAppliedScale = require(util:WaitForChild("getAppliedScale"))
local e = Roact.createElement

local FitList = Roact.Component:extend("FitList")

function FitList:init()
	self.sizeBinding, self.setSize = Roact.createBinding(UDim2.new())
	self.listRef = Roact.createRef()
end

function FitList:refit(instance)
	local fitAxes = self.props.fitAxes or "XY"
	local containerProps = self.props.containerProps
	local paddingProps = self.props.paddingProps
	local minSize = self.props.minSize

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
			math.max(contentSize.X, minSize.X),
			math.max(contentSize.Y, minSize.Y)
		)
	end

	local combinedSize

	if fitAxes == "X" then
		combinedSize = UDim2.new(0, contentSize.X, containerProps.Size.Y.Scale, containerProps.Size.Y.Offset)
	elseif fitAxes == "Y" then
		combinedSize = UDim2.new(containerProps.Size.X.Scale, containerProps.Size.X.Offset, 0, contentSize.Y)
	elseif fitAxes == "XY" then
		combinedSize = UDim2.new(0, contentSize.X, 0, contentSize.Y)
	else
		error("Invalid fitAxes value")
	end

	self.setSize(combinedSize)
end

function FitList:didMount()
	local instance = self.listRef:getValue()
	self:refit(instance)
end

function FitList:render()
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
		["$Layout"] = e("UIListLayout", Dictionary.merge({
			SortOrder = Enum.SortOrder.LayoutOrder,
			[Roact.Change.AbsoluteContentSize] = function(instance)
				self:refit(instance)
			end,
			[Roact.Ref] = self.listRef
		}, layoutProps)),

		["$Padding"] = padding,
	})

	local fullContainerProps = Dictionary.merge(containerProps, {
		Size = self.sizeBinding,
	})

	return e(containerKind, fullContainerProps, children)
end

return FitList