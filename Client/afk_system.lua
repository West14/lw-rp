afk_time = 0
openedesc = false
function startAFKtimer( )
	if afk_timer then
		stopAFKtimer( )
	else
		openedesc = true
		afk_timer = setTimer( setTimerValue, 1000, 0 )
	end
	
end

function onKey( button, state )
	if isLogged(lp) then
		if state then
			if button == "escape" then
				if openedesc then
					stopAFKtimer( )
				else
					startAFKtimer()
				end
			end
		end
	end
end
addEventHandler( "onClientKey", getRootElement(), onKey )

function setTimerValue( )
		afk_time = afk_time + 1
		outputChatMessage("Вы были в афк "..afk_time.." секунд!","#00FF00")
end

function stopAFKtimer( )
	killTimer( afk_timer )
	afk_time = 0
	openedesc = false
end