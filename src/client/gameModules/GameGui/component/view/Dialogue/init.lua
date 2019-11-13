local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local Dialogue = Roact.PureComponent:extend("Dialogue")

function Dialogue:init()
end

function Dialogue:didMount()
end

function Dialogue:render()
    
end

return Dialogue