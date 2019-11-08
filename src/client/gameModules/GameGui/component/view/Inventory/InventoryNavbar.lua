local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local component = script:FindFirstAncestor("component")

local Roact = require(lib:WaitForChild("Roact"))


local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitText = require(component:WaitForChild("FitText"))
local ItemTagDropdown = require(component:WaitForChild("ItemTagDropdown"))

local InventoryNavbar = Roact.PureComponent:extend("InventoryNavbar")

function InventoryNavbar:init()
end

function InventoryNavbar:didMount()
end

function InventoryNavbar:render()
    return Roact.createElement(FitList, {
        scale = 1,
        containerProps = {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            ZIndex = 2,
        },
        paddingProps = {
            PaddingLeft = UDim.new(0,8),
        },
        layoutProps = {
            Padding = UDim.new(0,8),
            FillDirection = Enum.FillDirection.Horizontal,
        }
    }, {
        searchLabel = Roact.createElement(FitText, {
            scale = 1,
            Text = "Search:",
            Font = Enum.Font.GothamBlack,
            minSize = Vector2.new(0,32),
            TextSize = 18,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1,
        }),
        searchContainer = Roact.createElement(RoundFrame, {
            color = Color3.fromRGB(216, 216, 216),
            Size = UDim2.new(0,200,1,0),
            LayoutOrder = 2,
        }, {
            padding = Roact.createElement("UIPadding", {
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
            }),
            textInput = Roact.createElement("TextBox", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1,0,1,0),
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 18,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Text = "",
                PlaceholderText = "Search",
                ClearTextOnFocus = false,
                [Roact.Event.Changed] = function(rbx,prop)
                    if prop == "Text" then
                        self.props.searchUpdate(rbx.Text)
                    end
                end
            })
        }),
        spacer = Roact.createElement("Frame", {
            Size = UDim2.new(0,16,1,0),
            BackgroundTransparency = 1,
            LayoutOrder = 3,
        }),
        catagoryLabel = Roact.createElement(FitText, {
            scale = 1,
            Text = "Catagory:",
            Font = Enum.Font.GothamBlack,
            minSize = Vector2.new(0,32),
            TextSize = 18,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 4,
        }),
        catagoryDropdown = Roact.createElement(ItemTagDropdown, {
            onSelect = function(tag)
                self.props.tagUpdate(tag.id)
            end,

            Size = UDim2.new(0,150,1,0),
            LayoutOrder = 5,
        })
    })
end

return InventoryNavbar