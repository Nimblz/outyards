local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

local Camera = Workspace.CurrentCamera
local TopInset, BottomInset = GuiService:GetGuiInset()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("uiComponents")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local ScreenScaler = require(component:WaitForChild("ScreenScaler"))

local function withScale(kind)
    return function(props)
        local children = props[Roact.Children]

        local prunedProps = Dictionary.join(props, {
            [Roact.Children] = Dictionary.None,
        })

        local joinedChildren = Dictionary.join(children, {
            ["$Scale"] = Roact.createElement(ScreenScaler, ScreenScaler.defaultProps)
        })

        return Roact.createElement(kind, prunedProps, joinedChildren)
    end
end

return withScale