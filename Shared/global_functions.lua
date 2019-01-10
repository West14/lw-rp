ids = {}
function removeHex(text, digits) -- функция с вики.
    assert(type(text) == "string", "Bad argument 1 @ removeHex [String expected, got " .. tostring(text) .. "]")
    assert(digits == nil or (type(digits) == "number" and digits > 0), "Bad argument 2 @ removeHex [Number greater than zero expected, got " .. tostring(digits) .. "]")
    return string.gsub(text, "#" .. (digits and string.rep("%x", digits) or "%x+"), "")
end

function isLogged(thePlayer)
	return getElementData(thePlayer, "logged")
end

function realTime() -- спёрто с МТА вики
    local realtime = getRealTime()

    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end
addEventHandler("onResourceStart", getResourceRootElement(), realTime)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end

function assignID(lp) -- перебирает ид, когда игрок подключается, через цикл for, и если ids[i] пусто,то оно заполняется данными игрока.
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

function isLogged(thePlayer) -- проверка на авторизацию
	return getElementData(thePlayer, "logged")
end