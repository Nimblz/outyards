return function()
    return {

        -- game actions
        attack = {
            inputs = {
                {
                    type = Enum.UserInputType.MouseButton1,
                    keyCode = nil, -- respond to all inputs of the type
                    state = Enum.UserInputState.Begin, -- trigger on this state
                },
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.F,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonR2,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        roll = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.LeftShift,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonL2,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        interact = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.E,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonX,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        special = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.R,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonY,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        trinket = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.Q,
                    state = Enum.UserInputState.Begin,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.DPadDown,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        nextWeapon = {
            inputs = {
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonR1,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
        prevWeapon = {
            inputs = {
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonL1,
                    state = Enum.UserInputState.Begin,
                },
            },
        },
    }
end