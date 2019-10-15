local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Promise = require(lib:WaitForChild("Promise"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Actions = require(common:WaitForChild("Actions"))

local Notifications = PizzaAlpaca.GameModule:extend("Notifications")

Notifications.SEVERITY = {
    SUCCESS = Color3.fromRGB(26, 155, 24),
    INFO = Color3.fromRGB(66, 151, 255),
    WARNING = Color3.fromRGB(255, 221, 28),
    ERROR = Color3.fromRGB(220, 25, 25),
}

function Notifications:addNotification(id,props,timeout)
    assert(typeof(id) == "string", "Passed id must be a string")
    assert(typeof(props) == "table", "Passed props must be a table")
    if not self.store then
        warn("Store not initialized, cannot push notification "..tostring(id))
        return
    end

    if self.timeouts[id] then self.timeouts[id]:cancel() end

    self.store:dispatch(Actions.NOTIFICATION_ADD(
        id,
        props
    ))

    if timeout then
        self.timeouts[id] = Promise.async(function(resolve)
            delay(timeout, resolve)
        end):andThen(function()
            self.store:dispatch(Actions.NOTIFICATION_REMOVE(id))
        end)
    end
end

function Notifications:preInit()
end

function Notifications:init()
    self.storeContainer = self.core:getModule("StoreContainer")
    self.timeouts = {}

    self.storeContainer:getStore():andThen(function(store)
        self.store = store
        self:addNotification("gamestart", {
            text = "Welcome to outyards! Thanks for playing!",
            status = self.SEVERITY.SUCCESS,
            thumbnail = "rbxassetid://247423655",
        }, 5)
    end)
end

function Notifications:postInit()
end


return Notifications