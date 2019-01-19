Faction = {
	[1] ={["name"] = ""}
}

function FactionSendMessage(player,msg)
	if getElementData(player,"faction") ~= 0 then
		local query = dbQuery(factionChatCallback,{player,msg},dbHandle,"SELECT * FROM `online` WHERE fr_id='"..getElementData(player,"faction").."'")
	end
end

function factionChatCallback(qh,player,msg)
	local result = dbPoll(qh,0)
	if result then
		local rank = getElementData(player,"rank")
		local name = getElementData(player,"nick")
		local faction = getElementData(player,"faction")
		local rankname = Faction[faction]["rank_names"][rank]
		for col,row in ipairs(result) do
			local playersend = ids[row.id]
			triggerClientEvent(playersend,"outputChatMessage",playersend,rankname.." "..name..": "..msg)
		end
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
			setElementData(veh,"fuel",row.fuel)
			setElementData(veh,"id",row.carid)
			setVehicleColor(veh,row.r,row.g,row.b)
		end
	end
	outputServerLog("Vehicles parsed!")
	dbFree(qh)
end

function FactionSetRankName(pl,rank,name)
	if getElementData(pl,"leader") then
		
	end
end	

function FactionGetRankNames()
	local qh = dbQuery(parseFactionRanks,dbHandle,"SELECT * FROM `faction`")
end
addEventHandler("onResourceStart",root,FactionGetRankNames)

function parseFactionRanks(qh)
	local result = dbPoll(qh,0)
	if result then
		for i,row in ipairs(result) do
			local id = row.id
			Faction[id]["name"] = row.name
			Faction[id]["budget"] = row.budget
			Faction[id]["salary"] = row.salary
			Faction[id]["rank_names"] = fromJSON(row.rank_names)
			Faction[id]["spawns"] = row.spawns
		end
	end
end

function FactionUpdateRank()
	if frid ~= 0 then
		local qh = dbQuery(parseFactionRank,{frid},dbHandle,"SELECT `rank_names` FROM `faction` WHERE id='"..frid.."'")
	end
end

function parseFactionRank(qh,frid)
	local result = dbPoll(qh,0)
	if result then
		for col,row in ipairs(result) do
			Faction[frid] = fromJSON(row.rank_names)
		end
	end
end