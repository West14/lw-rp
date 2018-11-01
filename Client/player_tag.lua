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
				dxSetRenderTarget( global_rendertarget, true )
				dxDrawText ( "#000000"..text, sx+1, sy + 1, sx+1, sy+1, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx+1, sy - 1, sx+1, sy-1, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx-1, sy + 1, sx-1, sy+1, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx-1, sy - 1, sx-1, sy-1, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx-1, sy, sx, sy, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
   				dxDrawText ( "#000000"..text, sx, sy - 1, sx, sy, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx, sy, sx-1, sy, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
    			dxDrawText ( "#000000"..text, sx, sy, sx, sy-1, tocolor ( 0, 0, 0, 255 ), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center",false,false,false,true)
				
				dxDrawText(text, sx, sy, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1.2)-(distanceBetweenPoints / distance), font or "default-bold", "center", "center")
				dxSetRenderTarget( )
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), 
function ()
	for k,v in ipairs(getElementsByType("player")) do
		if isElementStreamedIn( v ) then
			if isLogged(v) then
				dxDrawTextOnElement(v,getElementData( v,"nick").." [ "..getElementData(v,"id").." ]",1,20,255,255,255)
			end
		end
	end
end)

function dxDrawGlobalRenderTarget( )
	dxDrawImage( 0, 0, screenW, screenH, global_rendertarget)
end
addEventHandler( "onClientRender", getRootElement(), dxDrawGlobalRenderTarget )