function FactionSendMessage(player,msg)
	if getElementData(player,"faction") ~= 0 then
		local query = dbQuery(factionChatCallback,dbHandle)
	end
end

function parseFactionVehicles()
	local query = dbQuery(parseFactionCallback,dbHandle,"SELECT * FROM `vehicles` WHERE `faction`")
	outputServerLog("Parsing vehicles...")
end
addEventHandler("onResourceStart", root, parseFactionVehicles)

function parseFactionCallback(qh)
	local result = dbPoll(qh, 0)
	if result then
		for _,row in ipairs(result) do
			local veh = createVehicle(row.modelid,row.sx,row.sy,row.sz,row.rx,row.ry,row.rz,row.number)
			setVehicleEngineState(veh, false)
			setElementData(veh,"frid",row.faction)
			setElementData(veh, "id",row.carid)
			setVehicleColor(veh,row.r,row.g,row.b)
		end
	end
	outputServerLog("Vehicles parsed!")
	dbFree(qh)
end

function FactionSetRankName(pl,rank,name)
	if getElementData(player,"leader") then
		
	end
end	