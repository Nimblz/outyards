local magnitudes_en_us = {
    [1] = "K",
    [2] = "M",
    [3] = "B",
    [4] = "T",
    [5] = "Qd",
    [6] = "Qt",
    [7] = "Sx",
    [8] = "Sp",
    [9] = "Ot",
    [10] = "Nn",
    [11] = "De",
    [12] = "Ud",
    [13] = "Dd",
    [14] = "Td",
    [15] = "QdD",
    [16] = "QtD",
    [17] = "SxD",
    [18] = "SpD",
    [19] = "OtD",
    [20] = "NnD",
    [21] = "Vi",
}

local localeMagnitudeWidths = {
    en_us = 3,
}

local localeSuffixes = {
    en_us = magnitudes_en_us,
}

local function snapFloor(x,increment)
    return math.floor((x/increment))*increment
end

return function(inNumber, dontTruncate, locale, suffixWidth)
    dontTruncate = dontTruncate or false
    locale = locale or "en_us"
    assert(typeof(inNumber) == "number")

    local magnitudeWidth = localeMagnitudeWidths[locale] or 3
    local magnitudes = localeSuffixes[locale]
    if inNumber == math.huge then return "Infinity" end -- auto translate should catch this?

    local magnitude = math.floor(math.log10(inNumber))
    local suffix = magnitudes[math.floor(magnitude/magnitudeWidth)]

    if not suffix then return tostring(inNumber) end

    local fraction = inNumber/(10^(math.floor(magnitude/magnitudeWidth)*magnitudeWidth))
    local snapped = snapFloor(fraction, 0.001) -- snap to avoid rounding
    local formattedNumber = ("%."..(suffixWidth or magnitudeWidth).."f"):format(snapped)
    if not dontTruncate then
        formattedNumber = string.gsub(formattedNumber, "0+$", "")
        formattedNumber = string.gsub(formattedNumber, "%.+$", "")
    end
    return ("%s%s"):format(formattedNumber,suffix)
end