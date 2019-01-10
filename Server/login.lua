function onLogIn(lp, nick, pass)
	nick = removeHex(nick)
	isRegistered(nick, 
		function(state)
			if state then
				triggerClientEvent(lp, "outputChatMessage", lp, "Аккаунт с таким никнеймом не найден, пожалуйста зарегистрируйтесь.", "#990000")
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
				dbExec(dbHandle, "INSERT INTO `accounts`(nick, password) VALUES(?, ?)", nick, pass)
				triggerClientEvent(lp, "outputChatMessage", lp, "Добро пожаловать, " .. nick, "#D667FF")
				setElementData(lp, "nick",  nick)
				fadeCamera(lp, true)
				triggerClientEvent(lp,"onPlayerAuth", lp)
				setCameraMatrix(lp, 177.953125,-88.08984375,1002.6156616211,277.91015625,-86.4990234375,1000.1518554688)
				setElementInterior(lp, 18, 181.3447265625, -88.0458984375, 1002.0307006836)
				showCursor(lp,true)
				triggerClientEvent(lp,"setSkin",lp)
			else
				triggerClientEvent(lp, "outputChatMessage", lp, "Аккаунт с таким никнеймом уже зарегистрирован, используйте другой.", "#990000")
			end
		end
	)
end

function onPlayerOff( )
	for i,v in pairs(table_admins) do
		if source == v then
			table.remove(table_admins,i)
			outputDebugString( getElementData(v,"nick").." администратор вышел из игры.", 0, 255, 76, 91 )
		end
	end
end
addEventHandler( "onPlayerQuit", getRootElement(), onPlayerOff )

function doLogIn(qh, lp, nick, pass)
	local result = dbPoll(qh, 0)
	if result then
		for _, row in ipairs(result) do
			if pass ~= row["password"] then
				triggerClientEvent(lp, "outputChatMessage", lp, "Неверный пароль.", "#990000")
			else
				triggerClientEvent(lp, "outputChatMessage", lp, "Добро пожаловать, " .. nick, "#FFFFFF")
				setElementData(lp, "acc_id", row["id"])
				setElementData(lp, "nick",  nick)
				setElementData(lp, "logged", true)
				setElementData(lp, "level",row["level"])
				setElementData(lp, "exp",row["exp"])
				setElementData(lp, "alevel", row["admin"] )
				setElementData(lp, "skin", row["skin"])
				setElementData(lp, "fraction", row["fraction"])
				setElementData(lp, "leader", row["leader"])
				setElementData(lp, "walkstyle", row["walkstyle"])
				setPedWalkingStyle( lp, walkstyles[row["walkstyle"]] )
				if row["admin"] > 0 then
					table.insert(table_admins,lp)
					outputDebugString( nick.." авторизовался как администратор "..row["admin"].." уровня", 0, 255, 76, 91 )
				end
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent(lp,"onPlayerAuth", lp)
				fraction = row["fraction"]
				if fraction > 0 then
					spawnPlayer(lp, Fraction_spawn[fraction][1], 50, row["skin"])
					setElementInterior(lp,Fraction_spawn[fraction][2])
				else
					spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50, row["skin"])
				end
				
				showCursor(lp,false)
			end
		end
	else
		triggerClientEvent(lp, "outputChatMessage", lp, "Произошла непредвиденная ошибка. Попробуйте ещё раз.", "#990000")
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


function onEndRegister( thePlayer, skin )
	setElementData(thePlayer, "skin", skin)
	spawnPlayer(thePlayer, 391.658203125, -1524.560546875, 32.266296386719, 50,skin)
	fadeCamera(thePlayer,true)
	setCameraTarget(thePlayer,thePlayer)
	setElementInterior(thePlayer,0)
end
addEvent("onClientEndRegister",true)
addEventHandler("onClientEndRegister",root,onEndRegister)