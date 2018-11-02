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
