function isLocalPlayerActive ()
	if isMainMenuActive() then
      	setElementData(getLocalPlayer(),"status","afk")
	elseif isMainMenuActive() == false then
      	setElementData(getLocalPlayer(),"status","playing")
	end
end
addEventHandler( "onClientRender", getRootElement(), isLocalPlayerActive )


function onMinimize()
	setElementData(getLocalPlayer(),"status","afk")
end
addEventHandler( "onClientMinimize",root,onMinimize )

function onRestore()
	setElementData(getLocalPlayer(),"status","playing")
end
addEventHandler( "onClientRestore", root, onRestore )