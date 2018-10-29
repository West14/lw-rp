encKey = "c3CKcjgKDGiVfyN8"

function initScript()
	dbSetup()
end

addEventHandler("onResourceStart", getRootElement(), initScript)



function onLogIn(lp, nick, pass)
	nick = removeHex(nick)
	isRegistered(nick, 
		function(state)
			if state then
				triggerClientEvent(lp,"outputChatMessage",lp,"#990000Аккаунт с таким никнеймом не найден, пожалуйста зарегистрируйтесь.")
			else
				local qh = dbQuery(doLogIn, {lp, nick, pass}, dbHandle, "SELECT * FROM `accounts` WHERE `nick` = ?", nick)
			end
		end
	)
end

function onSignIn(lp, nick, pass)
	nick = removeHex(nick)
	isRegistered(nick, 
		function(state)
			if state then
				dbExec(dbHandle, "INSERT INTO `accounts`(nick, password, gender, skin) VALUES(?, ?, 1, 0)", nick, pass)
				triggerClientEvent(lp,"outputChatMessage",lp,"#009900Добро пожаловать, " .. nick)
				setElementData(lp, "logged", true)
				setElementData(lp, "nick",  nick)
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent("onPlayerAuth", lp)
				spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, -50)
				--showCursor(lp,true)
				triggerClientEvent(lp,"setSkin",lp)
			else
				triggerClientEvent(lp,"outputChatMessage",lp,"#990000Аккаунт с таким никнеймом уже зарегистрирован, используйте другой.")
			end
		end
	)
end

function doLogIn(qh, lp, nick, pass)
	local result = dbPoll(qh, 0)
	if result then
		for _, row in ipairs(result) do
			if pass ~= row["password"] then
				triggerClientEvent(lp,"outputChatMessage",lp,"#990000Неверные данные.")
			else
				triggerClientEvent(lp,"outputChatMessage",lp,"#009900Добро пожаловать, " .. nick)
				setElementData(lp, "logged", true)
				setElementData(lp, "nick",  nick)
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent("onPlayerAuth", lp)
				spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50, row["skin"])
				showCursor(lp,false)
			end
		end
	else
		triggerClientEvent(lp,"outputChatMessage",lp,"#990000Произошла непредвиденная ошибка. Попробуйте ещё раз.")
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

function addDataToDataBase( nick, column, value )
	dbExec(dbHandle, "UPDATE `accounts` SET ??=? WHERE nick=?", column, value, nick)


addEvent("addDataToDataBase",true)
addEventHandler("addDataToDataBase",root,addDataToDataBase)

function removeData()
	local players = getElementsByType ( "player" )
	for theKey,thePlayer in ipairs(players) do -- use a generic for loop to step through each player
		setElementData(thePlayer,"skin",nil)
		setElementData(thePlayer,"nick",nil)
		setElementData(thePlayer,"logged",false)
	end
end
addEventHandler("onResourceStop",root,removeData)