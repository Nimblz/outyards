local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local PizzaAlpaca = require(lib.PizzaAlpaca)

local Logger = PizzaAlpaca.GameModule:extend("Logger")

local LOG_FORMAT_STRING = "[%s][%s]: %s"

local logtype = {
    OUTPUT = 1,
    WARNING = 2,
    SEVERE = 3,
}

local logtypeNames = {
    [logtype.OUTPUT] = "OUTPUT",
    [logtype.WARNING] = "WARNING",
    [logtype.SEVERE] = "SEVERE",
}

local printFuncs = {
    [logtype.OUTPUT] = print,
    [logtype.WARNING] = warn,
    [logtype.SEVERE] = function(msg)
        -- Todo: send this to a webserver so nim can review it
        error(msg,3) -- delicious red text.
    end
}

local logger = {}

function logger:log(msg, severity)
    local module = self.module
    severity = severity or logtype.OUTPUT
    printFuncs[severity or logtype.OUTPUT](LOG_FORMAT_STRING:format(
        tostring(module),
        tostring(logtypeNames[severity]),
        tostring(msg))
    )
end

function Logger:create() -- constructor, fired on instantiation, core will be nil.
    self.logtype = logtype
end

function Logger:createLogger(module)
    local newLogger = setmetatable({},{__index = logger})
    newLogger.module = module
    newLogger.logtype = logtype

    return newLogger
end

return Logger