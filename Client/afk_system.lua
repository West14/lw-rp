function isLocalPlayerActive ()
	if isMainMenuActive() then
      	setElementData(getLocalPlayer(),"status","afk")
	elseif isMainMenuActive() == false then
      	setElementData(getLocalPlayer(),"status","playing")
	end
end
addEventHandler( "onClientRender", getRootElement(), isLocalPlayerActive )
