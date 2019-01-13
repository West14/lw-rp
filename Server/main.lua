encKey = "c3CKcjgKDGiVfyN8"
walkstyles = {
	[1] = 0,
	[2] = 118,
	[3] = 121,
	[4] = 129
}

walkstyles_anim = {
	[1] = "walk_player",
	[2] = "walk_civi",
	[3] = "walk_gang1",
	[4] = "woman_walknorm"
}
table_admins = {}

ids = {}

function initScript()
	dbSetup()
	
end

addEventHandler("onResourceStart", getRootElement(), initScript)

function dbSetup()
	dbHandle = dbConnect("mysql", "dbname=jabkarp;host=127.0.0.1;charset=utf8", "jabka", "root")
	if dbHandle then		
		outputServerLog("[MySQL] Connection successfull")
	else
		outputServerLog("[MySQL] Connection error")
	end
end


function onPayDay( )
	local players = getElementsByType ( "player" ) -- get a table of all the players in the server
	for k,v in ipairs(ids) do
		if isLogged(v) then
			triggerClientEvent("outputChatMessage",v,"PAYDAY")
			setElementData(v,"exp",getElementData(v,"exp")+1)
			if getElementData(v,"exp")*getElementData(v,"level") >= getElementData(v,"level")*4 then
				addDataToDataBase(getElementData(v,"nick"),'exp',0)
				setElementData(v,"level",getElementData(v,"level")+1)
				addDataToDataBase(getElementData(v,"nick"),'level',getElementData(v,"level"))
			else
				addDataToDataBase(getElementData(v,"nick"),'exp',getElementData(v,"exp")+1)
			end
		end
	end
end
addEvent("onPayDay",true)
addEventHandler("onPayDay",root,onPayDay)

addEventHandler("onPlayerWasted", root, 
	function()
		setTimer(spawnPlayer, 2000, 1, source, 391.658203125, -1524.560546875, 32.266296386719, 50, getElementData(source, "skin"))
	end
)

function checkTime( )
	local timer = getRealTime()
	seconds = timer.second
	if minutes == 0 then
		onPayDay()
	end
end
setTimer( checkTime, 1000, 0 )

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
		if id then 
			ids[id] = v 
		end 
    end 
end 
addEventHandler("onResourceStart",resourceRoot,startup) 

function freeID() -- освобождение ид, когда игрок выходит.
	dbExec(dbHandle,"DELETE FROM `online` WHERE id='"..getElementData(source,"id").."'")
    local id = getElementData(source,"id") 
    if not id then return end 
	ids[id] = nil 
end 
addEventHandler("onPlayerQuit",root,freeID) 

function getPlayers()
	triggerClientEvent("onReturnPlayers",source,ids,getMaxPlayers())
end
addEvent("onClientGetsPlayers",true)
addEventHandler("onClientGetsPlayers",root,getPlayers)