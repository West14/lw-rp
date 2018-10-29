encKey = "c3CKcjgKDGiVfyN8"

function initScript()
	dbSetup()
end

addEventHandler("onResourceStart", getRootElement(), initScript)



function onLogIn(lp, nick, pass)
	isRegistered(nick, 
		function(state)
			if state then
				outputChatBox("Аккаунт с таким никнеймом не найден, пожалуйста зарегистрируйтесь.", lp)
			else
				local qh = dbQuery(doLogIn, {lp, nick, pass}, dbHandle, "SELECT * FROM `accounts` WHERE `nick` = ?", nick)
			end
		end
	)
end

function onSignIn(lp, nick, pass)
	isRegistered(nick, 
		function(state)
			if state then
				dbExec(dbHandle, "INSERT INTO `accounts`(nick, password, gender) VALUES(?, ?, 1)", nick, pass)
				outputChatBox("Добро пожаловать, " .. nick, lp)
				setElementData(lp, "logged", true)
				setElementData(lp, "nick",  nick)
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent("onPlayerAuth", lp)
				spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50)
			else
				outputChatBox("Аккаунт с таким никнеймом уже зарегистрирован, используйте другой.", lp)
			end
		end
	)
end

function doLogIn(qh, lp, nick, pass)
	local result = dbPoll(qh, 0)
	if result then
		for _, row in ipairs(result) do
			if pass ~= row["password"] then
				outputChatBox("Пароль неправильный", lp)
			else
				outputChatBox("Добро пожаловать, " .. nick, lp)
				setElementData(lp, "logged", true)
				setElementData(lp, "nick",  nick)
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent("onPlayerAuth", lp)
				spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50)
			end
		end
	else
		outputChatBox("Произошла непредвиденная ошибка. Попробуйте ещё раз.", lp)
	end
end


addEvent("onPlayerLogIn", true)
addEventHandler("onPlayerLogIn", getRootElement(), onLogIn)

addEvent("onPlayerSignIn", true)
addEventHandler("onPlayerSignIn", getRootElement(), onSignIn)



function isRegistered(nick, callback)
	dbQuery(
		function(qh)
			local result = dbPoll(qh, 0)
			if #result == 0 then
				callback(true)
			else 
				callback(false)
			end
		end
		,dbHandle, "SELECT * FROM `accounts` WHERE `nick` = ? LIMIT 1", nick)
end

function dbSetup()
	dbHandle = dbConnect("mysql", "dbname=jabkarp;host=127.0.0.1;charset=utf8", "root", "")
	if dbHandle then		
		outputServerLog("[MySQL] Connection successfull")
	else
		outputServerLog("[MySQL] Connection error")
	end
end

function isLogged(thePlayer)
	return getElementData(thePlayer, "logged")
end