local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Items = require(common:WaitForChild("Items"))
local Sprites = require(common:WaitForChild("Sprites"))
local Selectors = require(common:WaitForChild("Selectors"))
local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))

local ItemNotifier = PizzaAlpaca.GameModule:extend("ItemNotifier")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

local function getChanges(old,new)
    local changes = {}
    for key,newValue in pairs(new) do
        local oldValue = old[key]
        if not oldValue then
            changes[key] = newValue
        else
            local diff = newValue - oldValue
            changes[key] = diff
        end
    end
    return changes
end

local function getSpriteProps(id)
    local item = Items.byId[id]
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(item, errors.invalidItemId:format(tostring(id)))
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteRectSize = spriteSheet.spriteSize * spriteSheet.scaleFactor
    local spriteRectOffset = Vector2.new(
        (item.spriteCoords.X-1) * spriteSheet.spriteSize.X,
        (item.spriteCoords.Y-1) * spriteSheet.spriteSize.Y
    )   * spriteSheet.scaleFactor

    return {
        image = spriteSheet.assetId,
        rectSize = spriteRectSize,
        rectOffset = spriteRectOffset,
    }
end

function ItemNotifier:preInit()
end

function ItemNotifier:init()
end

function ItemNotifier:postInit()
    local storeContainer = self.core:getModule("StoreContainer")
    local notifications = self.core:getModule("Notifications")
    storeContainer:getStore():andThen(function(store)
        store.changed:connect(function(newState,oldState)
            local oldItems = Selectors.getInventory(oldState, LocalPlayer)
            local newItems = Selectors.getInventory(newState, LocalPlayer)

            local changes = getChanges(oldItems,newItems)

            for id, diff in pairs(changes) do
                local item = Items.byId[id]
                local spriteProps = getSpriteProps(id)
                if diff > 0 then
                    notifications:addNotification("item_add_"..id,{
                        text = ("Got %d %s"):format(diff,item.name),
                        status = notifications.SEVERITY.SUCCESS,
                        thumbnail = spriteProps.image,
                        rectSize = spriteProps.rectSize,
                        rectOffset = spriteProps.rectOffset,
                    }, 3)
                elseif diff < 0 then
                    -- removed notif
                end
            end
        end)
    end)
end

return ItemNotifier