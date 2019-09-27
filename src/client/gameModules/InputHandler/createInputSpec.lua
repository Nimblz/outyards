return function()
    return {

        -- game actions
        attack = {
            inputs = {
                {
                    type = Enum.UserInputType.MouseButton1,
                    keyCode = nil, -- respond to all inputs of the type
                },
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.LeftControl,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonR2,
                },
            },
        },

        roll = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.LeftShift,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonL2,
                },
            },
        },

        interact = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.E,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonX,
                },
            },
        },

        special = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.R,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonY,
                },
            },
        },

        trinket = {
            inputs = {
                {
                    type = Enum.UserInputType.Keyboard,
                    keyCode = Enum.KeyCode.Q,
                },
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.DPadDown,
                },
            },
        },

        nextWeapon = {
            inputs = {
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonR1,
                },
            },
        },
        prevWeapon = {
            inputs = {
                {
                    type = Enum.UserInputType.Gamepad1,
                    keyCode = Enum.KeyCode.ButtonL1,
                },
            },
        },

        mouseMoved = {
            inputs = {
                {
                    type = Enum.UserInputType.MouseMovement
                }
            }
        }
    }
end