--[[afk_time = 0
openedesc = false
function startAFKtimer( )
	afk_timer = setTimer( setTimerValue, 1000, -1 )
end
addEventHandler( "onClientMinimize", getRootElement(), startAFKtimer )

function onKey( button, state )
	if isLogged(lp) then
		if state then
			if button == "escape" then
				if openedesc then
					openedesc = false
					stopAFKtimer( )
				else
					openedesc = true
					afk_timer = setTimer( setTimerValue, 1000, -1 )
				end
			end
		end
	end
end
addEventHandler( "onClientKey", getRootElement(), onKey )

function setTimerValue( )
	afk_time = afk_time + 1
end

function stopAFKtimer( )
	resetTimer( afk_timer )
end
addEventHandler( "onClientRestore", getRootElement(), stopAFKtimer )]]