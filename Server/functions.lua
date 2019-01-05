ids = {}
function isLogged(thePlayer) -- проверка на авторизацию
	return getElementData(thePlayer, "logged")
end

function addDataToDataBase( nick, column, value ) -- обновление данных в бд с клиента
	dbExec(dbHandle, "UPDATE `accounts` SET ??=? WHERE nick=?", column, value, nick)
end

addEvent("addDataToDataBase",true)
addEventHandler("addDataToDataBase",root,addDataToDataBase)

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

function getPlayer( player )
	if type(player) == "number" then
		return getPlayerByID(player)
	elseif isElement( player ) then
		return player
	end
end

function getPlayerByNick( nick )
	for k, v in ipairs(getElementsByType("player")) do 
	    if getElementData(v,"nick") == nick then
	      	return v
	    end
    end 
end

function getAlevel( player )
	return getElementData( player, "alevel")
end

function removeNick() 
    setPlayerNametagShowing ( source, false ) 
end 
addEventHandler ("onPlayerJoin", root, removeNick) 