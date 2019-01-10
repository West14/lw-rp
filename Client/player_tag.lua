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
				dxDrawText(text, sx+1, (sy/1.1)+1, sx+1, sy+1, tocolor(0,0,0, 155), size or 1.0, font or tagFont, "center", "top")
				dxDrawText(text, sx-1, (sy/1.1)+1, sx+1, sy-1, tocolor(0,0,0, 155), size or 1.0, font or tagFont, "center", "top")
				dxDrawText(text, sx+1, (sy/1.1)-1, sx+1, sy-1, tocolor(0,0,0, 155), size or 1.0, font or tagFont, "center", "top")
				dxDrawText(text, sx-1, (sy/1.1)-1, sx, sy, tocolor(0,0,0, 155), size or 1.0, font or tagFont, "center", "top")
				
				dxDrawText(text, sx, sy/1.1, sx-1, sy-1, tocolor(R or 255, G or 255, B or 255, alpha or 255), size or 1.0, font or tagFont, "center", "top")
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

function renderTagStreamedInPlayers( )
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn( v ) then
			if v ~= lp then
				dxDrawTextOnElement(v,getElementData( v,"nick").." [ "..getElementData(v,"id").." ]",1,20,255,255,255)
				status = getElementData(v, "status")
				if status == "afk" then	
					dxDrawTextOnElement(v,"AFK ",1.2,219, 219, 219)
					--dxDrawTextOnElement(v,afktime .. " секунд",1.2,219, 219, 219)
				end
			end
		end
	end
end
addEventHandler( "onClientRender", getRootElement(), renderTagStreamedInPlayers )
