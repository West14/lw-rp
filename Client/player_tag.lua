function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx, sy/1.1, sx-1, sy-1, tocolor(R or 255, G or 255, B or 255, alpha or 255), size or 1.2, font or "default-bold", "center", "center")
			end
		end
	end
end

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

addEventHandler("onClientRender", getRootElement(), 
function ()
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn( v ) then
			if isLogged(v) and getElementData(v,"id")  then
				if v ~= lp then
					dxDrawTextOnElement(v,getElementData( v,"nick").." [ "..getElementData(v,"id").." ]",1,20,255,255,255)
					afktime = getElementData( v, "afktime")
					if afktime ~= 0 then
						afktime = math.floor((getTickCount() - afktime) / 1000)
						dxDrawTextOnElement(v,"AFK ".. afktime .. " секунд",1.5,219, 219, 219)
					end
				end
			end
		end
	end
end)



addEventHandler("onClientRender", root,
function ()
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn(v) then
			if isLogged(v) and getElementData(v, "id")  then
				local x, y, z = getElementPosition(v)
				local x2, y2, z2 = getCameraMatrix()
				local distance = distance or 20
				local height = height or 1
				if v ~= lp then
					if (isLineOfSightClear(x, y, z+2, x2, y2, z2)) then
						local sx, sy = getScreenFromWorldPosition(x, y, z+height)
						if(sx) and (sy) then
							local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
							if(distanceBetweenPoints < distance) then													
								dxDrawRectangle(sx / 1.0625, sy/1.02, getPedArmor(v), screenH * 0.01, tocolor(225, 227, 232))
								dxDrawRectangle(sx / 1.0625, sy/0.99, getElementHealth(v), screenH * 0.01, tocolor(255, 0, 0))
								dxDrawLinedRectangle(sx / 1.0625, sy/0.99, 100, screenH * 0.01, tocolor(0,0,0), 2, false)
								if (getPedArmor(v) > 0) then
									dxDrawLinedRectangle(sx / 1.0625, sy/1.02, 100, screenH * 0.01, tocolor(0,0,0), 2, false)
								end
							end
						end
					end
				end
			end
		end
	end
end )