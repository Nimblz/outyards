local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local PizzaAlpaca = require(lib:WaitForChild("PizzaAlpaca"))
local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))
local EquipmentBehaviors = require(common:WaitForChild("EquipmentBehaviors"))
local EquipmentRenderers = require(common:WaitForChild("EquipmentRenderers"))

local Equipment = PizzaAlpaca.GameModule:extend("Equipment")

local function camRayFromMousePos(mousePos)
    local cam = Workspace.CurrentCamera
    if not cam then return end

    return cam:ScreenPointToRay(mousePos.X,mousePos.Y,1)
end

local function getDiffs(before,after)
    local added, removed = {}, {}
    local beforeSet, afterSet = {}, {}

    -- create before hash set
    for _,v in pairs(before) do
        beforeSet[v] = true
    end
    -- create after hash set and check against before set to find new elements
    for _,v in pairs(after) do
        afterSet[v] = true
        -- do this here to cut out an extra for loop
        if not beforeSet[v] then
            table.insert(added,v)
        end
    end
    -- check before against after set to find removed
    for _,v in pairs(before) do
        if not afterSet[v] then
            table.insert(removed,v)
        end
    end

    return added,removed
end

local function newObject(prototype, player , itemId, pzCore)
    return setmetatable({
        itemId = itemId,
        pzCore = pzCore,
        player = player,
    }, {__index = prototype})
end

function Equipment:create()
    self.behaviors = {} -- behaviors[player][id]
    self.renderers = {} -- renderers[player][id]
end

function Equipment:getBehaviors(player)
    return self.behaviors[player]
end

function Equipment:getRenderers(player)
    return self.renderers[player]
end

function Equipment:getBehavior(player,id)
    return self:getBehaviors(player)[id]
end

function Equipment:getRenderer(player,id)
    return self:getRenderers(player)[id]
end

function Equipment:recieveProps(player,id,props)
    local behavior = self:getBehavior(player,id)
    behavior:updateProps(props)
end

function Equipment:clearRenderers(player)
    for _,renderer in pairs(self:getRenderers(player)) do
        renderer:destroy()
    end
    self.renderers[player] = {}
end

function Equipment:clearBehaviors(player)
    for _,behavior in pairs(self:getBehaviors(player)) do
        behavior:destroy()
    end
    self.behaviors[player] = {}
end

function Equipment:characterSpawned(player,char)
    -- repopulate renderers and behaviors

    -- clear incase they didnt get removed somehow
    self:clearBehaviors(player)
    self:clearRenderers(player)

    local equipped = Selectors.getEquipped(self.store:getState(), player) or {}
    for _, itemId in pairs(equipped) do
        self:playerEquipped(player,itemId)
    end
end

function Equipment:playerAdded(player)
    self.behaviors[player] = {}
    self.renderers[player] = {}

    player.CharacterAdded:connect(function(char)
        local humanoid = char:WaitForChild("Humanoid")
        char:WaitForChild("HumanoidRootPart")
        char:WaitForChild("Head")

        humanoid.Died:connect(function()
            self:clearBehaviors(player) -- behaviors should clear immediately on death
        end)

        self:characterSpawned(player,char)
    end)

    player.CharacterRemoving:connect(function()
        self:clearBehaviors(player)
        self:clearRenderers(player)
    end)
end

function Equipment:playerLeaving(player)
    for _,behavior in pairs(self.behaviors[player]) do
        behavior:destroy()
    end
    for _,renderer in pairs(self.renderers[player]) do
        renderer:destroy()
    end
    self.behaviors[player] = nil
    self.renderers[player] = nil
end

function Equipment:playerEquipped(player,itemId)
    -- find behavior for this equipment and create new instance
    -- do same for renderer

    local item = Items.byId[itemId]
    assert(item, "Invalid item equipped: "..itemId)

    local behaviorType = item.behaviorType
    local rendererType = item.rendererType

    local renderers = self:getRenderers(player)
    local behaviors = self:getBehaviors(player)

    if behaviorType then
        local behavior = newObject(
            EquipmentBehaviors.byId[behaviorType],
            player,
            itemId,
            self.core
        )
        behavior:create()
        behaviors[itemId] = behavior
    end
    if rendererType then
        local renderer = newObject(
            EquipmentRenderers.byId[rendererType],
            player,
            itemId,
            self.core
        )
        renderer:create()
        renderers[itemId] = renderer
    end
end

function Equipment:playerUnequipped(player,itemId)
    local renderers = self:getRenderers(player)
    local behaviors = self:getBehaviors(player)

    renderers[itemId]:destroy()
    behaviors[itemId]:destroy()

    renderers[itemId] = nil
    behaviors[itemId] = nil
end

function Equipment:canAttack()
    local character = LocalPlayer.character
    if not character then return false end
    if not character.PrimaryPart then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

function Equipment:onAttackBegan()
    local inputHandler = self.core:getModule("InputHandler")
    -- activate all equipment behaviors
    local ourBehaviors = self:getBehaviors(LocalPlayer)
    local screenPos = inputHandler:getMousePos()
    local character = LocalPlayer.character
    local camRay = camRayFromMousePos(screenPos)
    local target, worldPos, worldNormal = Workspace:FindPartOnRayWithIgnoreList(
        Ray.new(camRay.Origin,camRay.Direction*512),
        {character, self.bulletBin}
    )

    local inputProps = {
        getMouse = function()
            return {
                screenPos = inputHandler:getMousePos(),
                worldPos = worldPos,
                worldNormal = worldNormal,
                hit = CFrame.new(worldPos,worldNormal),
                target = target,
            }
        end
    }

    for _,behavior in pairs(ourBehaviors) do
        behavior:activated(inputProps)
    end
end

function Equipment:onAttackEnded()
    -- deactivate all equipment behaviors
    local ourBehaviors = self:getBehaviors(LocalPlayer)
    for _,behavior in pairs(ourBehaviors) do
        behavior:deactivated()
    end
end

function Equipment:postInit()
    local storeContainer = self.core:getModule("StoreContainer")

    self.bulletBin = workspace:WaitForChild("bullets")

    storeContainer:getStore():andThen(function(store)
        -- on store change, for each player, collect differences in equipped items
        -- for each diff, add and remove those behaviors
        self.store = store

        store.changed:connect(function(newState, oldState)
            coroutine.wrap(function()
                for _, player in pairs(Players:GetPlayers()) do
                    local newEquipped = Selectors.getEquipped(newState,player) or {}
                    local oldEquipped = Selectors.getEquipped(oldState,player) or {}
                    local added,removed = getDiffs(oldEquipped,newEquipped)

                    for _, itemId in pairs(removed) do
                        self:playerUnequipped(player,itemId)
                    end

                    for _, itemId in pairs(added) do
                        self:playerEquipped(player,itemId)
                    end
                end
            end)()
        end)

        Players.playerAdded:connect(function(player)
            self:playerAdded(player)
        end)

        Players.PlayerRemoving:connect(function(player)
            self:playerLeaving(player)
        end)

        for _,player in pairs(Players:GetPlayers()) do
            self:playerAdded(player)
        end

        -- bind activation stuff
        local inputHandler = self.core:getModule("InputHandler")

        local attack = inputHandler:getActionSignal("attack")

        attack.began:connect(function(input)
            self:onAttackBegan()
        end)

        attack.ended:connect(function(input)
            self:onAttackEnded()
        end)
    end)
end

return Equipment