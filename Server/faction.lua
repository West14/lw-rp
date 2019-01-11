function FactionSendMessage(player,msg)
	if getElementData(player,"faction") ~= 0 then
		local query = dbQuery(factionChatCallback,dbHandle)
	end
end
