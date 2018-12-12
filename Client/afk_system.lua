function isLocalPlayerActive ()
   if not(isMainMenuActive()) then
      startTimer = getTickCount()
      setElementData(lp,"afktime",startTimer)
  elseif isMainMenuActive() == false then
  		startTimer = 0
  		setElementData(lp,"afktime",nil)
   end
end
addEventHandler( "onClientRender", getRootElement(), isLocalPlayerActive )