function onLogIn(nick, pass)
	nick = removeHex(nick)
	isRegistered(nick, 
		function(state)
			if state then
				triggerClientEvent(lp, "outputChatMessage", lp, "Аккаунт с таким никнеймом не найден, пожалуйста зарегистрируйтесь.", "#990000")
			else
				
				
			end
		end
	)
end

function onSignIn(lp, nick, pass,email)
	nick = removeHex(nick)
	options = {
		formFields = {
			username=nick,
			email=email,
			password=pass,
		},
	}
	fetchRemote("https://forum.lw-rp.tk/reg.php", options, regCallback,{lp,nick})
end

function regCallback(responseData,errno,lp,nick)
	if type(errno) == "table" then
		responseData = fromJSON(responseData)
		if tonumber(responseData.code) == 1 then
			setElementData(lp, "logged", true)
			triggerClientEvent(lp, "outputChatMessage", lp, "Внимание, "..nick.." вы зарегистрирвали свой аккаунт на форум(forum.lw-rp.tk)")
			triggerClientEvent(lp, "outputChatMessage", lp, "Чтобы войти в следующий раз введите свой никнейм: "..nick..".")
			
			fadeCamera(lp, true)
			setElementData(lp,"logged", true)
			spawnPlayer(lp,0,0,0,0,162)
			triggerClientEvent(lp, "endSignUp",lp)
			setElementData(lp, "nick",  nick)
			showCursor(lp,true)
		elseif tonumber(responseData.code) == 2 then
			triggerClientEvent(lp, "errorSignUp", lp)
		end
	else
		
	end
end

function onPlayerOff( )
	for i,v in pairs(table_admins) do
		if source == v then
			table.remove(table_admins,i)
			outputDebugString( getElementData(v,"nick").." администратор вышел из игры.", 0, 255, 76, 91 )
		end
	end
end

function onEndRegister( thePlayer, skin )
	setElementData(thePlayer, "skin", skin)	
	spawnPlayer(thePlayer, 391.658203125, -1524.560546875, 32.266296386719, 50,98)
	fadeCamera(thePlayer,true)
	setCameraTarget(thePlayer,thePlayer)
	setElementInterior(thePlayer,0)
end

function onAuth(userid)
	local qh = dbQuery(authCallback,{client}, dbHandle, "SELECT * FROM `accounts` WHERE `forumid` ="..userid)
	--[[spawnPlayer(client,345,421,23,0,45)
	setCameraTarget(client,client)
	showCursor(client,false)
	setElementData(client,"logged",true)
	setElementData(client,"nick","Jabka_Devs")]]
end

function authCallback(qh,client)
	local result = dbPoll( qh, 0 )
	if result then
		triggerClientEvent("onReturnCharacters",client,result)
	end
end

function onSelectCharacter(table)
	faction = table.faction
	if faction > 0 then
		spawnPlayer(source, Faction_spawn[faction][1], 50, table.skin)
		setCameraTarget(source,source)
		setElementInterior(source,Faction_spawn[faction][2])
	else
		spawnPlayer(source, 391.658203125, -1524.560546875, 32.266296386719, 50, table.skin)
		setCameraTarget(source,source)
	end
	setPlayerMoney(source,table.money,false)
	local qh = dbQuery(function(qh,table)
		local result = dbPoll(qh,0)
		if result then
			for k,row in ipairs(result) do
				local veh = createVehicle(row.modelid,row.sx,row.sy,row.sz,row.rx,row.ry,row.rz,row.number)
				setElementData(veh,"pid",row.playerid)
				setElementData(veh, "id",row.carid)
				setVehicleColor(veh,row.r,row.g,row.b)
			end
		end
	end,{table},dbHandle,"SELECT * FROM `vehicles` WHERE playerid='"..table.id.."'")
	dbExec(dbHandle,"INSERT INTO `online`(`id`, `nick`, `fr_id`, `alevel`) VALUES ("..getElementData(source,"id")..",'"..table.nick.."',"..table.faction..","..table.admin..")")
end

addEvent("onPlayerLogIn", true)
addEvent("onClientEndRegister",true)
addEvent("onPlayerStartSignUp", true)
addEvent("getCharacters",true)
addEvent("onClientSelectCharacter",true)

addEventHandler("onPlayerLogIn", getRootElement(), onLogIn)
addEventHandler("onPlayerStartSignUp", getRootElement(), onSignIn)
addEventHandler("onClientEndRegister",root,onEndRegister)
addEventHandler( "onPlayerQuit", getRootElement(), onPlayerOff )
addEventHandler("onClientSelectCharacter",root,onSelectCharacter)
addEventHandler("getCharacters",root,onAuth)