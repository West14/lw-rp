function addDataToDataBase( nick, column, value ) -- обновление данных в бд с клиента
	dbExec(dbHandle, "UPDATE `accounts` SET ??=? WHERE nick=?", column, value, nick)
end

addEvent("addDataToDataBase",true)
addEventHandler("addDataToDataBase",root,addDataToDataBase)

function removeData()
	local players = getElementsByType ( "player" )
	for theKey,thePlayer in ipairs(players) do -- use a generic for loop to step through each player
		setElementData(thePlayer,"skin",nil)
		setElementData(thePlayer,"nick",nil)
		setElementData(thePlayer,"logged",false)
		setElementData(thePlayer, "level",nil)
		setElementData(thePlayer, "exp",nil)
		setElementData(thePlayer, "afktime", 0)
		setElementPosition( thePlayer, 0, 0, 0 )
		for i=#table_admins,1,-1 do
			table_admins[i] = nil
		end
	end
end
addEventHandler("onResourceStop",root,removeData)

function removeNick() 
	setPlayerNametagShowing ( source, false ) 
end 
addEventHandler ("onPlayerJoin", root, removeNick) 