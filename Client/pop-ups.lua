-- Поп-апы.

function createPopUp(text,time)
	starttick = getTickCount()
	popup_text = text
	popup_time = time
	alpha = 255
	addEventHandler( "onClientRender", getRootElement(), popUpRender )
end
addEvent( "createPopUp",true)
addEventHandler( "createPopUp", root, createPopUp )

function popUpRender( )
	local r1,g1,b1 = 195, 55, 100
	local r2,g2,b2 = 29,38,113
	local now = getTickCount()
    local elapsedTime = now - starttick
    local duration = popup_time - starttick
	dxDrawImage( screenW-5-332, screenH/2, 332, 111, "Images/bg_gradient.jpg",0,0,0,tocolor( 255, 255, 255,alpha))
	dxDrawText( popup_text, screenW-150, screenH/2,screenW150,screenH/2,tocolor( 255, 255, 255, alpha))
	if (now - starttick) / 1000 >= popup_time then
		now = nil
		starttick = nil
		addEventHandler( "onClientRender", getRootElement(), removePopUpRender )
	end
end

function removePopUpRender( )
	if alpha > 0 then
		alpha = alpha - 1
	else
		removeEventHandler( "onClientRender", root, popUpRender)
		removeEventHandler( "onClientRender", root, removePopUpRender)
	end
end