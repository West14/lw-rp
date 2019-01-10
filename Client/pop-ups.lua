-- Поп-апы.

function createPopUp(text,time)
	popuptick = getTickCount()
	popup_text = text
	popup_time = time
	alpha = 255
	addEventHandler( "onClientRender", getRootElement(), popUpRender )
end
addEvent( "createPopUp",true)
addEventHandler( "createPopUp", root, createPopUp )

function popUpRender( )
	if hud_visible then
		local r1,g1,b1 = 195, 55, 100
		local r2,g2,b2 = 29,38,113
		local now = getTickCount()
	    local elapsedTime = now - popuptick
	    local duration = popup_time - popuptick
	    if (now - popuptick) / 1000 >= popup_time then
	    	if not(isEventHandlerAdded("onClientRender", getRootElement(), removePopUpRender)) then
				addEventHandler( "onClientRender", getRootElement(), removePopUpRender )
			end
		end
		dxDrawRectangle(screenW * 0.7347, screenH * 0.4233, screenW * 0.2444, screenH * 0.0244, tocolor(0, 0, 0, alpha), false)
	    dxDrawRectangle(screenW * 0.7347, screenH * 0.4433, screenW * 0.2444, screenH * 0.1400, tocolor(51, 51, 51, alpha), false)
	    dxDrawText("Подсказка", screenW * 0.7340, screenH * 0.4233, screenW * 0.9764, screenH * 0.4478, tocolor(255, 255, 255, alpha), 1.00, "default-bold", "center", "center", false, false, false, true, false)
	    dxDrawText(popup_text, (screenW * 0.7347) - 1, (screenH * 0.4689) - 1, (screenW * 0.9792) - 1, (screenH * 0.5767) - 1, tocolor(0, 0, 0, alpha), 1.00, "default-bold", "center", "top", false, false, false, true, false)
	    dxDrawText(popup_text, (screenW * 0.7347) + 1, (screenH * 0.4689) - 1, (screenW * 0.9792) + 1, (screenH * 0.5767) - 1, tocolor(0, 0, 0, alpha), 1.00, "default-bold", "center", "top", false, false, false, true, false)
	    dxDrawText(popup_text, (screenW * 0.7347) - 1, (screenH * 0.4689) + 1, (screenW * 0.9792) - 1, (screenH * 0.5767) + 1, tocolor(0, 0, 0, alpha), 1.00, "default-bold", "center", "top", false, false, false, true, false)
	    dxDrawText(popup_text, (screenW * 0.7347) + 1, (screenH * 0.4689) + 1, (screenW * 0.9792) + 1, (screenH * 0.5767) + 1, tocolor(0, 0, 0, alpha), 1.00, "default-bold", "center", "top", false, false, false, true, false)
	    dxDrawText(popup_text, screenW * 0.7347, screenH * 0.4689, screenW * 0.9792, screenH * 0.5767, tocolor(255, 255, 255, alpha), 1.00, "default-bold", "center", "top", false, false, false, true, false)
	end
end

function removePopUpRender( )
	if alpha > 0 then
		alpha = alpha - 1
	else
		removeEventHandler( "onClientRender", root, removePopUpRender)
		removeEventHandler( "onClientRender", root, popUpRender)
	end
end