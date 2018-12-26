function onCommand(cmd)
	local func = "cmd_" .. cmd[1]
	if _G[func] then
		table.remove(cmd,1)
		assert(loadstring(func .. "(...)"))(cmd)
	else
		triggerClientEvent(source, "outputChatMessage", source, "Команда не найдена.", "#990000")
	end
end

addEvent("sendCommand", true)
addEventHandler("sendCommand",root, onCommand)


function cmd_a(args)
	local qh = dbQuery(doAchat, {source,args}, dbHandle, "SELECT `nick`, `admin` FROM `accounts` WHERE `admin` > 0")
end

function doAchat(qh,source,args)
	local result = dbPoll( qh, -1 )
	if result then
		for _,row in ipairs(result) do
			if getElementData( source, "nick") == row["nick"] then
				triggerClientEvent( table_admins, "outputAdminChatMessage", source, getElementData(source,"nick").."( "..row["admin"].." ): ", args )
			end
		end
	end
end

function cmd_admins( args )
	triggerClientEvent( source,"outputChatMessage", source, "Администраторы в сети:")
	for k,v in pairs(table_admins) do
		triggerClientEvent( source,"outputChatMessage", source, getElementData( v, "nick").."( "..getElementData( v, "alevel").. " )")
	end
end

function cmd_me(args)
	local msg = ""
	for i, theMsg in pairs(args) do
		msg = msg.." "..theMsg
	end
	if args[1] == nil then
		triggerClientEvent(source, "outputChatMessage", source, "Используйте /me [действие]", "#990000")
	else
		sendMessageToAll(source,15,"#D667FF",getElementData(source,"nick").."[ "..getElementData(source,"id").." ]: "..msg)
	end
end

function cmd_do(args)
	text = ""
	for i, theMsg in pairs(args) do
		text = text.." "..theMsg
	end
	text = removeHex(text)
	if string.len(text) > 0 then
		local lpName = getElementData(source,"nick")
		sendMessageToAll(source,15,"#D667FF",text.. " (( "..lpName.." ))")
	else
		triggerServerEvent("outputChatMessage",source,source,"Используйте: /do [Текст]", "#A9A9A9")
	end
end

function cmd_todo(args)
	local msg = ""
	for i, theMsg in pairs(args) do
		msg = msg.." "..theMsg
	end
	local first = split(msg,"*")
	local second = string.gsub(msg,unpack(first).."%*","")
	if string.len(string.gsub(unpack(first),"%s+","")) > 0 and string.len(string.gsub(second,"%s+","")) > 0 then
		sendMessageToAll(source,15,"#FFFFFF",unpack(first)..", - сказал "..getElementData(source,"nick")..", #D667FF"..second)
	end
end

function cmd_s( args )
	local msg = ""
	for i, theMsg in pairs(args) do
		msg = msg.." "..theMsg
	end
	if string.len(removeHex(msg)) > 0 and string.len(string.gsub(msg,"%*","")) > 0 then
		sendMessageToAll(source,20,nil, getElementData(source,"nick").."[ "..getElementData(source,"id").." ]: "..msg)
	end
end

function cmd_w( args )
	local msg = ""
	for i, theMsg in pairs(args) do
		msg = msg.." "..theMsg
	end
	if string.len(removeHex(msg)) > 0 and string.len(string.gsub(msg,"%*","")) > 0 then
		sendMessageToAll(source,10,nil, getElementData(source,"nick").."[ "..getElementData(source,"id").." ]: "..msg)
	end
end

function cmd_makeleader(args)
	player = args[1]
	player_leader = false
	fr_id = tonumber(args[2])
	player_id = tonumber(args[1])
	if type(player_id) == "number" then
		player = getPlayerByID(player_id)
		player_nick = getElementData( player, "nick")
	else
		player_nick = player
		player = getPlayerByNick(player_nick)
	end 
	setPlayerLeader(player,fr_id)
	if fr_id > 0 then
		triggerClientEvent( source,"outputChatMessage", source, "Вы назначили "..player_nick.." на пост лидера "..Fraction_list[fr_id])
		triggerClientEvent( player,"outputChatMessage", player, "Вы были назначены на пост лидера "..Fraction_list[fr_id])
		player_leader = true
	else
		triggerClientEvent( source,"outputChatMessage", source, "Вы сняли с поста лидера игрока "..player_nick)
		triggerClientEvent( player,"outputChatMessage", player, "Вы были сняты с поста лидера")
	end
	dbExec(dbHandle,"UPDATE `accounts` SET `fraction` = ?, `leader` = '?' WHERE `accounts`.`nick` = ?", fr_id,player_leader,player_nick)
end

function cmd_checkleader()
	local frac_id = getElementData(source,"leader")
	if frac_id == nil or frac_id == false then 
		triggerClientEvent( source, "outputChatMessage", source, "Вы не лидер")
	elseif frac_id >= 1 then
		triggerClientEvent( source, "outputChatMessage", source, "Вы лидер "..Fraction_list[frac_id])
	end
end

function cmd_pc()
	triggerClientEvent( source, "createPopUp", source,"TEST",5)
end