function isLocalPlayerActive ()
   if isMainMenuActive() then
       afkStart()
  else
  		afkStop()
   end
end
addEventHandler( "onClientRender", getRootElement(), isLocalPlayerActive )

function afkStart( )
	startTimer = getTickCount()
    setElementData(lp,"afktime",startTimer)
end

function afkStop( )
	if startTimer ~= 0 or startTimer ~= nil then
		startTimer = 0
  		setElementData(lp,"afktime",0)
	end
end