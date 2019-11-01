local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local util = common:WaitForChild("util")
local component = script:FindFirstAncestor("uiComponents")

local eRequestEquip = event:WaitForChild("eRequestEquip")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local FitList = require(component:WaitForChild("FitList"))
local FitText = require(component:WaitForChild("FitText"))
local ItemLabel = require(component:WaitForChild("ItemLabel"))
local ItemTagDropdown = require(script:WaitForChild("ItemTagDropdown"))

local makeView = require(script.Parent:WaitForChild("makeView"))
local contains = require(util:WaitForChild("contains"))

local Inventory = Roact.PureComponent:extend("Inventory")

function Inventory:fitsFilter(item)
    if not item then return false end

    local tagFilter = self.state.tagFilter

    local itemTags = item.tags or {}

    if contains(itemTags, tagFilter) then
        return true
    end

    if tagFilter == "equipped" then
        return self.props.isEquipped(item.id)
    end

    if tagFilter == "all" then
        return true
    end

    return false
end

function Inventory:fitsSearch(item)
    if not item then return false end

    local searchFilter = self.state.searchFilter:lower()
    local lowercaseName = item.name:lower()

    if searchFilter == "" then return true end

    if lowercaseName:match(searchFilter) then return true end

    return false
end

function Inventory:init()
    self:setState({
        tagFilter = "all",
        searchFilter = "",
    })
end

function Inventory:setTagFilter(newTag)
    self:setState({
        tagFilter = newTag,
    })
end

function Inventory:setSearchFilter(newSearch)
    self:setState({
        searchFilter = newSearch,
    })
end

function Inventory:render()
    local inventory = self.props.inventory

    local inventoryItems = {}
    for id, quantity in pairs(inventory) do
        if quantity > 0 then
            local item = Items.byId[id]
            if item and self:fitsFilter(item) and self:fitsSearch(item) then
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
    end

    inventoryItems.layout = Roact.createElement("UIGridLayout", {
        CellPadding = UDim2.new(0,0,0,0),
        CellSize = UDim2.new(0,80,0,80),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    inventoryItems.padding = Roact.createElement("UIPadding", {
        PaddingTop = UDim.new(0,16),
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
            Active = true,
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
                            print("spoo")
                            self:setSearchFilter(rbx.Text)
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
                    self:setTagFilter(tag.id)
                end,

                Size = UDim2.new(0,150,1,0),
                LayoutOrder = 5,
            })
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
                    PaddingTop = UDim.new(0,0),
                    PaddingBottom = UDim.new(0,0),
                    PaddingLeft = UDim.new(0,16),
                    PaddingRight = UDim.new(0,12),
                }),
                gridFrame = Roact.createElement("ScrollingFrame", {
                    Size = UDim2.new(1,0,1,0),
                    CanvasSize = UDim2.new(0,0,5,0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Selectable = false,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    TopImage = "rbxassetid://4271581206",
                    MidImage = "rbxassetid://4271580709",
                    BottomImage = "rbxassetid://4271581830",
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
        inventory = Selectors.getInventory(state,LocalPlayer),
        isEquipped = function(itemId) return Selectors.getIsEquipped(state,LocalPlayer,itemId) end,
    }
end

Inventory = RoactRodux.connect(mapStateToProps)(Inventory)
Inventory = makeView(Inventory, "inventory")

return Inventory