Fraction_list = {
	[1] = "LSPD",
	[2] = "Mayor"
}

function setPlayerLeader(player, fr_id )
	if fr_id > 0 and fr_id <= #Fraction_list then
		if type(player) == "number" then
			local player = getPlayerByID(args[2])
			setElementData( player, "leader", fr_id )
		elseif type(player) == "string" then
			setElementData( player, "leader", fr_id )
		end 
	end 
end