function onCommand(cmd)
	assert(loadstring("cmd_" .. cmd[1] .. "(...)"))(cmd)
end

function cmd_help(args)
	if args[2] == nil or args[3] == nil then 
		triggerClientEvent(source, "outputError", source, "Используйте /help [arg1] [arg2]") 
	else
		triggerClientEvent(source, "outputSuccess", source, "Вы ввели команду /help " .. args[2] .. " " .. args[3])
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
				for theKey, thePlayer in ipairs(admins) do
					triggerClientEvent( thePlayer, "outputAdminChatMessage", thePlayer, getElementData(source,"nick").."( "..row["admin"].." ): ", args )
				end
			end
		end
	end
end