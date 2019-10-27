-- PLAYER_JOINED thunk
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Actions = require(common:WaitForChild("Actions"))

local PLAYER_ADD = Actions.PLAYER_ADD

return function(player)
    return function(store)
        local defaultSave = {
            inventory = {
                wood = 10,
            },
        }
        local playerSaveTable = defaultSave
        if game.PlaceId ~= 0 then
            local DataStore2 = require(lib:WaitForChild("DataStore2"))

            -- load from datastore2
            local saveDataStore = DataStore2("saveData",player)
            local dataStore2SaveTable = saveDataStore:Get(nil)

            if dataStore2SaveTable then
                playerSaveTable = dataStore2SaveTable
            end
        end

        store:dispatch(PLAYER_ADD(player, playerSaveTable))
    end
end