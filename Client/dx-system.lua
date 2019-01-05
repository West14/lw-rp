local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
    for k, a in ipairs(t) do
        if a == v then
            return k
        end
    end
    return false
end

function animate(f, t, easing, duration, onChange, onEnd)
    assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
    assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
    assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
    assert(type(duration) == "number", "Bad argument @ 'animate' [expected function at argument 4, got "..type(duration).."]")
    assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
    table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
    return #anims
end

function destroyAnimation(a)
    if anims[a] then
        table.remove(anims, a)
    end
end

addEventHandler("onClientRender", root, function( )
    local now = getTickCount( )
    for k,v in ipairs(anims) do
        v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
        if now >= v.start+v.duration then
            if type(v.onEnd) == "function" then
                v.onEnd( )
            end
            table.remove(anims, k)
        end
    end
end)

function dxCreateRoundedTexture(text_width,text_height,radius)
    assert(text_width,"Missing argument 'text_width' at dxCreateRoundedTexture")
    assert(text_height,"Missing argument 'height' at dxCreateRoundedTexture")
    assert(radius,"Missing argument 'radius' at dxCreateRoundedTexture")
    if type(text_width) ~= "number" then outputDebugString("Bad argument @ 'dxCreateRoundedTexture' [Excepted number at argument 1, got " .. type(text_width) .. "]",2) return false end
    if type(text_height) ~= "number" then outputDebugString("Bad argument @ 'dxCreateRoundedTexture' [Excepted number at argument 2, got " .. type(text_height) .. "]",2) return false end
    if type(radius) ~= "number" then outputDebugString("Bad argument @ 'dxCreateRoundedTexture' [Excepted number at argument 3, got " .. type(radius) .. "]",2) return false end
    if text_width < 0 then outputDebugString("text_width can't be less than 0",1) return false end
    if text_height < 0 then outputDebugString("text_height can't be less than 0",1) return false end
    if radius < 0 or radius > 100 then outputDebugString("Parameter 'radius' can't be between 0 and 100",1) return false end

    local texture = DxTexture(text_width,text_height)
    local pix = texture:getPixels()

    radius = (radius * (text_height / 2)) / 100

    for x=0,text_width do
        for y=0,text_height do
            if x >= radius and x <= text_width - radius then
                dxSetPixelColor(pix,x,y,255,255,255,255)
            end
            if y >= radius and y <= text_height - radius then
                dxSetPixelColor(pix,x,y,255,255,255,255)
            end
            if math.sqrt((x - radius)^2 + (y - radius)^2) < radius then
                dxSetPixelColor(pix,x,y,255,255,255,255) -- lewy gorny rog
            end
            if math.sqrt((x - (text_width - radius))^2 + (y - radius)^2) < radius then
                dxSetPixelColor(pix,x,y,255,255,255,255) -- prawy gorny rog
            end
            if math.sqrt((x - radius)^2 + (y - (text_height - radius))^2) < radius then
                dxSetPixelColor(pix,x,y,255,255,255,255) -- lewy dolny rog
            end
            if math.sqrt((x - (text_width - radius))^2 + (y - (text_height - radius))^2) < radius then
                dxSetPixelColor(pix,x,y,255,255,255,255) -- prawy dolny rog
            end
        end
    end
    texture:setPixels(pix)
    return texture
end

function dxSmoothRoundedTexture( texture, x,y, width, height, mask )
    local mask = dxCreateTexture( mask )
    local shader = dxCreateShader("Shaders/smooth.fx")
    if shader and mask then


        dxSetShaderValue( shader, "Texture0",texture) -- текстура
        dxSetShaderValue( shader, "Texture1",mask) -- маска     

        return shader
    end

end

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 3)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 3)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 3)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 3)
    end
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function isCursorOverText(posX, posY, sizeX, sizeY)
    if(isCursorShowing()) then
        local cX, cY = getCursorPosition()
        local screenWidth, screenHeight = guiGetScreenSize()
        local cX, cY = (cX*screenWidth), (cY*screenHeight)
        if(cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) then
            return true
        else
            return false
        end
    else
        return false	
    end
end

local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
    for k, a in ipairs(t) do
        if a == v then
            return k
        end
    end
    return false
end

function animate(f, t, easing, duration, onChange, onEnd)
    assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
    assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
    assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
    assert(type(duration) == "number", "Bad argument @ 'animate' [expected function at argument 4, got "..type(duration).."]")
    assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
    table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
    return #anims
end

function destroyAnimation(a)
    if anims[a] then
        table.remove(anims, a)
    end
end

addEventHandler("onClientRender", root, function( )
    local now = getTickCount( )
    for k,v in ipairs(anims) do
        v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
        if now >= v.start+v.duration then
            if type(v.onEnd) == "function" then
                v.onEnd( )
            end
            table.remove(anims, k)
        end
    end
end)