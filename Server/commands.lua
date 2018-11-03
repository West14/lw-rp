function onCommand(cmd)
	local func = "cmd_" .. cmd[1]
	if _G[func] then
		assert(loadstring(func .. "(...)"))(cmd)
	else
		triggerClientEvent(lp, "outputChatMessage", lp, "Команда не найдена.", "#990000")
	end
end

addEvent("sendCommand", true)
addEventHandler("sendCommand",root, onCommand)


function cmd_a(args)
	local qh = dbQuery(doAchat, {source,args}, dbHandle, "SELECT `nick`, `admin` FROM `accounts` WHERE `admin` > 0")
end

function doAchat(qh,source,args)
	local result = dbPoll( qh, -1 )
	local players = getElementsByType( "player" )
	args[1] = nil
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
	args[1] = nil
	local msg = ""
	for i, theMsg in pairs(args) do
		msg = msg.." "..theMsg
	end
	if args[2] == nil then
		triggerClientEvent(source, "outputChatMessage", source, "Используйте /me [действие]", "#990000")
	else
		triggerClientEvent(source, "outputChatMessage", source, getElementData(source, "nick") .. msg, "#D667FF")
	end
end