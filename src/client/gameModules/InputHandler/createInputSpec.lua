return function()
    return {
        attack = {
            inputs = {
                {
                    type = Enum.UserInputType.MouseButton1,
                    keyCode = nil, -- respond to all inputs of the type
                    passThrough = true, -- dont block
                    state = Enum.UserInputState.Begin, -- trigger on this state
                },
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.F,
                    passThrough = true,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonR1,
                    passThrough = true,
                    state = Enum.UserInputState.Begin,
                },
            }
        },
        roll = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.LeftShift,
                    passThrough = true,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonL1,
                    passThrough = true,
                    state = Enum.UserInputState.Begin,
                },
            }
        }
    }
end