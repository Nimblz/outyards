local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common

local Selectors = require(common.Selectors)
local PizzaAlpaca = require(lib.PizzaAlpaca)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Actions = require(common.Actions)
local Thunks = require(common.Thunks)
local component = script.component
local App = require(component.App)

local GuiContainer = PizzaAlpaca.GameModule:extend("GuiContainer")

local function makeApp(store, props)
    local storeProvider = Roact.createElement(RoactRodux.StoreProvider, {
        store = store,
    }, {
        app = Roact.createElement(App, props)
    })

    return storeProvider
end

function GuiContainer:preInit()
    PlayerGui:SetTopbarTransparency(0)
    GuiService.AutoSelectGuiEnabled = true
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
end

function GuiContainer:init()

    Roact.setGlobalConfig({elementTracing = true})

    self.logger = self.core:getModule("Logger"):createLogger(self)

    local storeContainer = self.core:getModule("StoreContainer")
    local inputHandler = self.core:getModule("InputHandler")

    local openInventory = inputHandler:getActionSignal("openInventory")
    local openCrafting = inputHandler:getActionSignal("openCrafting")

    local cancel = inputHandler:getActionSignal("cancel")

    storeContainer:getStore():andThen(function(store)

        store:dispatch(Thunks.VIEW_SET("default"))


        cancel.began:connect(function()
            store:dispatch(Thunks.VIEW_SET("default"))
        end)

        openInventory.began:connect(function()
            local currentView = Selectors.getView(store:getState())
            local targetView = "inventory"
            if currentView == "dialogue" then return end
            targetView = ((currentView ~= targetView) and targetView) or "default"
            store:dispatch(Thunks.VIEW_SET(targetView))
        end)

        openCrafting.began:connect(function()
            local currentView = Selectors.getView(store:getState())
            local targetView = "crafting"
            if currentView == "dialogue" then return end
            targetView = ((currentView ~= targetView) and targetView) or "default"
            store:dispatch(Thunks.VIEW_SET(targetView))
        end)

        local screenSizer = Instance.new("ScreenGui")
        screenSizer.Name = "ScreenSizeReporter"
        screenSizer.Parent = PlayerGui
        screenSizer:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
            store:dispatch(Actions.SCREENSIZE_SET(screenSizer.AbsoluteSize))
        end)

        self.appHandle = Roact.mount(makeApp(store, {
            pzCore = self.core,
        }), PlayerGui)
        self.logger:log("UI Mounted")
    end)
end

function GuiContainer:postInit()
end

return GuiContainer