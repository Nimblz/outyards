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
    self.logger:log("Starting Cmdr!")
    local admins = {
        "Nimblz",
        "Nacker",
        "MITB",
        "Kinnis97",
        "Chronomad",
    }

    for i = 1,8 do -- add Player1 thru Player8
        table.insert(admins, "Player"..i)
    end

    for k,v in pairs(admins) do
        admins[k] = v:lower()
    end

    self.logger:log("Registering hooks...")
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

    self.logger:log("Registering types...")
    Cmdr:RegisterTypesIn(types)

    self.logger:log("Registering commands...")
    Cmdr:RegisterDefaultCommands()
    Cmdr:RegisterCommandsIn(commands)

    self.logger:log("Cmdr started!")
end

function CmdrContainer:init()
    local storeContainer = self.core:getModule("StoreContainer")
    local recsContainer = self.core:getModule("ServerRECSContainer")

    self.logger = self.core:getModule("Logger"):createLogger(self)

    Promise.all({
        storeContainer:getStore(),
        recsContainer:getCore()
    }):andThen(function(results)
        self:onResolve(unpack(results))
    end)
end

return CmdrContainer