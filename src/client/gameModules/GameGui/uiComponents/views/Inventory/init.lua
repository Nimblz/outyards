local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local component = script:FindFirstAncestor("uiComponents")

local eRequestEquip = event:WaitForChild("eRequestEquip")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundTextElement = require(component:WaitForChild("RoundTextElement"))
local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitText = require(component:WaitForChild("FitText"))
local ItemLabel = require(component:WaitForChild("ItemLabel"))
local Inventory = Roact.Component:extend("Inventory")

local makeView = require(script.Parent:WaitForChild("makeView"))

function Inventory:init()
end

function Inventory:didMount()
end

function Inventory:render()
    local inventory = self.props.inventory

    local inventoryItems = {}
    for id, quantity in pairs(inventory) do
        if quantity > 0 then
            local item = Items.byId[id]
            local itemSortOrder = item.sortOrder
            local newItemLabel = Roact.createElement(ItemLabel, {
                itemId = id,
                quantity = quantity,
                activatable = true,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5,0,0.5,0),
            })

            local itemFrame = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(0,64,0,64),
                LayoutOrder = itemSortOrder,
            }, {item = newItemLabel})

            inventoryItems[id] = itemFrame
        end
    end

    inventoryItems.layout = Roact.createElement("UIGridLayout", {
        CellPadding = UDim2.new(0,0,0,0),
        CellSize = UDim2.new(0,80,0,80),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    return Roact.createElement(FitList, {
        containerKind = RoundFrame,
        scale = 1,
        layoutProps = {
            Padding = UDim.new(0,16)
        },
        paddingProps = {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,16),
            PaddingRight = UDim.new(0,16),
        },
        containerProps = {
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            ZIndex = 2,
        }
    }, {
        title = Roact.createElement("TextLabel", {
            Text = "Inventory",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,0,32),
            TextSize = 32,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,

            LayoutOrder = 1,
        }),
        navbar = Roact.createElement(FitList, {
            scale = 1,
            containerProps = {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
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
                Text = "🔎",
                Font = Enum.Font.GothamBlack,
                minSize = Vector2.new(0,32),
                TextSize = 24,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 1,
            }),
            searchContainer = Roact.createElement(RoundFrame, {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,256,1,0),
                LayoutOrder = 2,
            }, {
                padding = Roact.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0,16),
                }),
                textInput = Roact.createElement("TextBox", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1,0,1,0),
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 18,
                    Text = "",
                    PlaceholderText = "Search",
                })
            }),
            nextButton = Roact.createElement(RoundTextElement, {
                kind = "TextButton",
                Size = UDim2.new(0,72,0,32),
                Text = "Next",
                Font = Enum.Font.GothamSemibold,
                TextSize = 18,
                LayoutOrder = 3,
                color = Color3.fromRGB(216, 216, 216)
            }),
            prevButton = Roact.createElement(RoundTextElement, {
                kind = "TextButton",
                Size = UDim2.new(0,72,0,32),
                Text = "Prev",
                Font = Enum.Font.GothamSemibold,
                TextSize = 18,
                LayoutOrder = 4,
                color = Color3.fromRGB(216, 216, 216)
            }),
        }),
        body = Roact.createElement(FitList, {
            scale = 1,
            containerProps = {
                BackgroundTransparency = 1,
                LayoutOrder = 3,
            },
            layoutProps = {
                Padding = UDim.new(0,16),
                FillDirection = Enum.FillDirection.Horizontal,
            }
        }, {
            itemsView = Roact.createElement(RoundFrame, {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,450,0,450)
            }, {
                padding = Roact.createElement("UIPadding", {
                    PaddingTop = UDim.new(0,16),
                    PaddingBottom = UDim.new(0,16),
                    PaddingLeft = UDim.new(0,16),
                    PaddingRight = UDim.new(0,16),
                }),
                gridFrame = Roact.createElement("Frame", {
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Selectable = false,
                }, inventoryItems)
            }),
            itemFocus = Roact.createElement(RoundFrame, {
                color = Color3.fromRGB(216, 216, 216),
                Size = UDim2.new(0,250,0,450)
            }),
        })
    })
end

local function mapStateToProps(state,props)
    return {
        inventory = Selectors.getInventory(state,LocalPlayer)
    }
end

Inventory = RoactRodux.connect(mapStateToProps)(Inventory)
Inventory = makeView(Inventory, "inventory")

return Inventory