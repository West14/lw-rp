function initScript()
	dbSetup()

end

addEventHandler("onResourceStart", getRootElement(), initScript)



function onLogIn(lp, nick, pass)
	setElementData(source, "logged", true)
	setElementData(source, "nick",  nick)
	-- ну и тут дальше, шо делать надо при логине, хы. Пока-что просто заспавним игрока.
	triggerClientEvent("onPlayerAuth", source)
	spawnPlayer(source, 215.5875,-155.7573,1000.5234-0.5)
	fadeCamera(source, true)
	setCameraTarget(source, source)
end

function onSignIn(lp, nick, pass)
	local temp = isRegistered(nick)
	if temp == true then
		outputChatBox("Аккаунт с таким именем уже существует, попробуйте другое.", source)
		outputServerLog("test")
	end
end

addEvent("onPlayerLogIn", true)
addEventHandler("onPlayerLogIn", getRootElement(), onLogIn)

addEvent("onPlayerSignIn", true)
addEventHandler("onPlayerSignIn", getRootElement(), onSignIn)



function isRegistered(nick)
	local q = dbQuery(
		function(qh)
			local result = dbPoll(qh, 0)
			if #result == 0 then
				return true
			else 
				return false
			end
		end
		,dbHandle, "SELECT * FROM `accounts` WHERE `nick` = ? LIMIT 1", nick)
end

function dbSetup()
	dbHandle = dbConnect("mysql", "dbname=jabkarp;host=127.0.0.1;charset=utf8", "root", "")
	if (not dbHandle) then
		outputServerLog("[MySQL] Connection error")
	else
		outputServerLog("[MySQL] Connection successfull")
	end
end

function isLogged(thePlayer)
	return getElementData(thePlayer, "logged")
end