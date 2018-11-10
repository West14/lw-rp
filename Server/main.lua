encKey = "c3CKcjgKDGiVfyN8"
ids = {} 
function initScript()
	dbSetup()
	table_admins = {}
end

addEventHandler("onResourceStart", getRootElement(), initScript)

--  РЕГИСТРАЦИЯ

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
				setElementData(lp, "nick",  nick)
				setElementData(lp, "logged", true)
				setElementData(lp, "level",row["level"])
				setElementData(lp, "exp",row["exp"])
				setElementData(lp, "alevel", row["admin"] )
				setElementData(lp, "skin", row["skin"])
				if row["admin"] > 0 then
					table.insert(table_admins,lp)
					outputDebugString( nick.." авторизовался как администратор "..row["admin"].." уровня", 0, 255, 76, 91 )
				end
				fadeCamera(lp, true)
				setCameraTarget(lp, lp)
				triggerClientEvent(lp,"onPlayerAuth", lp)
				spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50, row["skin"])
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

function dbSetup()
	dbHandle = dbConnect("mysql", "dbname=jabkarp;host=127.0.0.1;charset=utf8", "jabka", "root")
	if dbHandle then		
		outputServerLog("[MySQL] Connection successfull")
	else
		outputServerLog("[MySQL] Connection error")
	end
end

function isLogged(thePlayer) -- проверка на авторизацию
	return getElementData(thePlayer, "logged")
end

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
		setElementPosition( thePlayer, 0, 0, 0 )
		for i=#table_admins,1,-1 do
			table_admins[i] = nil
		end
	end
end
addEventHandler("onResourceStop",root,removeData)

-- ID SYSTEM

function assignID() -- перебирает ид, когда игрок подключается, через цикл for, и если ids[i] пусто,то оно заполняется данными игрока.
    for i=1,getMaxPlayers() do 
        if not ids[i] then 
            ids[i] = source 
            setElementData(source,"id",i)
            break 
        end 
    end 
end 
addEventHandler("onPlayerJoin",root,assignID) 

function removeNick() 
    setPlayerNametagShowing ( source, false ) 
end 
addEventHandler ("onPlayerJoin", root, removeNick) 
  
function startup() -- когда ресурс запускается, то сервер проверяет игроков на наличие данных ид в игроке.
    for k, v in ipairs(getElementsByType("player")) do 
        local id = getElementData(v,"id") 
        if id then ids[id] = v end 
    end 
end 
addEventHandler("onResourceStart",resourceRoot,startup) 

function freeID() -- освобождение ид, когда игрок выходит.
    local id = getElementData(source,"id") 
    if not id then return end 
    ids[id] = nil 
end 
addEventHandler("onPlayerQuit",root,freeID) 

function getPlayerByID(id) -- взять игрока через ид.
    local player = ids[id] 
    return player or false 
end
addEventHandler("getPlayerByID",root,getPlayerByID)
addEvent("getPlayerByID",true)

function getPlayerID(player) -- функция взятия ид из игрока
    for k, v in ipairs(ids) do 
        if v == player then return 1 end 
    end 
end 
addEventHandler("getPlayerID",root,getPlayerID)
addEvent("getPlayerID",true)

function onEndRegister( thePlayer, skin )
	setElementData(thePlayer, "skin", skin)
	spawnPlayer(thePlayer, 391.658203125, -1524.560546875, 32.266296386719, 50,skin)
	fadeCamera(thePlayer,true)
	setCameraTarget(thePlayer,thePlayer)
	setElementInterior(thePlayer,0)
end
addEvent("onClientEndRegister",true)
addEventHandler("onClientEndRegister",root,onEndRegister)

function onPayDay( )
	local players = getElementsByType ( "player" ) -- get a table of all the players in the server
	for k,v in ipairs(ids) do
		if v == player then
			if isLogged(player) then
				triggerClientEvent("outputChatMessage",player,"PAYDAY")
				setElementData(player,"exp",getElementData(player,"exp")+1)
				if getElementData(player,"exp")*getElementData(player,"level") >= getElementData(player,"level")*4 then
					addDataToDataBase(getElementData(player,"nick"),'exp',0)
					addDataToDataBase(getElementData(player,"nick"),'level',getElementData(player,"level")+1)
				else
					addDataToDataBase(getElementData(player,"nick"),'exp',getElementData(player,"exp")+1)
				end
			end
		end
	end
end
addEvent("onPayDay",true)
addEventHandler("onPayDay",root,onPayDay)

function getAlevel( player )
	return getElementData( player, "alevel")
end

addEventHandler("onPlayerWasted", root, 
	function()
		spawnPlayer(lp, 391.658203125, -1524.560546875, 32.266296386719, 50, getElementData(source, "skin"))
	end
	)