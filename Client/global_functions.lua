hud_visible = true
function showHud(btn, press)
	if (press) then
		if btn == "F7" then
			local components = {"ammo","breath","clock","money","vehicle_name","weapon"}
			if hud_visible then
				for k,v in pairs(components) do
					setPlayerHudComponentVisible( v, false )
				end
				hud_visible = false
				dxSetRenderTarget( renderChatTarget, true)
				dxSetRenderTarget()
				if isEventHandlerAdded("onClientRender",root, openChat) then
					clearChatBox()
				end
			else
				hud_visible = true
				for k,v in pairs(components) do
					setPlayerHudComponentVisible( v, true )
				end
				TextFuel()
			end
		end
	end
end
addEventHandler( "onClientKey", getRootElement(), showHud )