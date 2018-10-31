function removeHex(text, digits) -- функция с вики.
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (digits and string.rep("%x", digits) or "%x+"), "")
end

function isLogged(thePlayer)
	return getElementData(thePlayer, "logged")
end

function realTime() -- спёрто с МТА вики
    local realtime = getRealTime()

    setTime(realtime.hour + 3, realtime.minute)
    setMinuteDuration(60000)
end
addEventHandler("onResourceStart", getResourceRootElement(), realTime)