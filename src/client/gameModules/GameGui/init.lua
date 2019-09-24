local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local lib = ReplicatedStorage:WaitForChild("lib")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local uiComponents = script:WaitForChild("uiComponents")
local App = require(uiComponents.App)

local GuiContainer = PizzaAlpaca.GameModule:extend("GuiContainer")

local function makeApp(store)
    local storeProvider = Roact.createElement(RoactRodux.StoreProvider, {
        store = store,
    }, {
        app = Roact.createElement(App, {})
    })

    return storeProvider
end

function GuiContainer:preInit()
end

function GuiContainer:init()

    Roact.setGlobalConfig({elementTracing = true})

    self.logger = self.core:getModule("Logger"):createLogger(self)

    local storeContainer = self.core:getModule("StoreContainer")
    storeContainer:getStore():andThen(function(store)
        self.appHandle = Roact.mount(makeApp(store), PlayerGui)
        self.logger:log("UI Mounted")
    end)
end

function GuiContainer:postInit()
end

return GuiContainer