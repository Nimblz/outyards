-- Author: Tiffany Benett

local TextService = game:GetService("TextService")

local baselineTable = {
    [Enum.Font.Arial]            =  1.15,
    [Enum.Font.ArialBold]        =  1.15,
    [Enum.Font.SourceSans]       =  1.257,
    [Enum.Font.SourceSansBold]   =  1.257,
    [Enum.Font.SourceSansLight]  =  1.257,
    [Enum.Font.SourceSansItalic] =  1.257,
    [Enum.Font.Bodoni]           =  1.192,
    [Enum.Font.Garamond]         =  1.20,
    [Enum.Font.Cartoon]          =  1.209,
    [Enum.Font.Code]             =  1.049,
    [Enum.Font.Highway]          =  1.107,
    [Enum.Font.SciFi]            =  1.20,
    [Enum.Font.Arcade]           =  1.025,
    [Enum.Font.Fantasy]          =  1.018,
    [Enum.Font.Antique]          =  1.049,
    [Enum.Font.Gotham]           =  1.20,
    [Enum.Font.GothamBlack]      =  1.20,
    [Enum.Font.GothamBold]       =  1.20,
    [Enum.Font.GothamSemibold]   =  1.20,
}

local function getSize(props)
    local text = props.text
    if type(text) ~= "string" then
        text = text:getValue()
    end

    local bounds = TextService:GetTextSize(text, props.textSize, props.font, Vector2.new(100000, 100000))

    local width = math.min(props.maxWidth or math.huge, bounds.X)

    if props.useBaseline then
        local ratio = baselineTable[props.font]
        -- Fudge factors to make it look right
        local nominal = (props.textSize - 3.5) / ratio
        local height = math.floor(nominal + 3.5)

        return Vector2.new(width, height + props.baselineOffset)
    end

    return Vector2.new(width, bounds.Y)
end

return getSize