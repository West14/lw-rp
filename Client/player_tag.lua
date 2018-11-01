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
				dxDrawText(text, sx, sy, sx-1, sy-1, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1.2)+(distanceBetweenPoints / distance * 2), font or "sans", "center", "center")
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), 
function ()
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn( v ) then
			if isLogged(v) and getElementData(v,"id")  then
				if v ~= lp then
					dxDrawTextOnElement(v,getElementData( v,"nick").." [ "..getElementData(v,"id").." ]",1,20,255,255,255)
				end
			end
		end
	end
end)