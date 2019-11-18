local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local commands = script.commands
local types = script.types
local util = common.util

local Cmdr = require(lib.Cmdr)
local PizzaAlpaca = require(lib.PizzaAlpaca)
local Promise = require(lib.Promise)

local contains = require(util.contains)

local CmdrContainer = PizzaAlpaca.GameModule:extend("CmdrContainer")

function CmdrContainer:onResolve(store, recsCore)

    local admins = {
        "Nimblz",
        "Nacker",
        "MITB",
        "Kinnis97",
        "Chronomad",
        "Player1",
        "Player2",
        "Player3",
        "Player4",
        "Player5",
        "Player6",
        "Player7",
        "Player8",
    }

    for k,v in pairs(admins) do
        admins[k] = v:lower()
    end

    Cmdr.Registry:RegisterHook("BeforeRun", function(context)
        context.State.pzCore = self.core
        context.State.store = store
        context.State.recsCore = recsCore
    end)

    Cmdr.Registry:RegisterHook("BeforeRun", function(context)
		if context.Group:lower():match("admin") and not contains(admins, context.Executor.Name:lower()) then
			return "You don't have permission to run this command"
		end
    end)

    Cmdr:RegisterDefaultCommands()
    Cmdr:RegisterCommandsIn(commands)
    Cmdr:RegisterTypesIn(types)
end

function CmdrContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")
    local recsContainer = self.core:getModule("ServerRECSContainer")

    Promise.all({
        storeContainer:getStore(),
        recsContainer:getCore()
    }):andThen(function(results)
        self:onResolve(unpack(results))
    end)
end

return CmdrContainer