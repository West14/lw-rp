Fraction_list = {
	[1] = "LSPD",
	[2] = "Mayor"
}
Fraction_spawn = {
	[1] = {
		Vector3(391.658203125,-1524.560546875,52.266296386719),0},
	[2] = Vector3(0,0,0)
}

function setPlayerLeader(player, fr_id )
	if fr_id > 0 and fr_id <= #Fraction_list then
		setElementData( player, "leader", fr_id )
	elseif fr_id == 0 then
		setElementData(player, "leader",false)
	end 
end

function getPlayerFraction(player)
	player = getPlayer( player )
	return getElementData( player, "fraction")
end

function isLeader( player )
	return getElementData( player, "leader")
end

function fraction_invite(player,rank)
	if isLeader(lp) then
		if type(player) == "player" then
			if rank > 0 then
				setElementData( player, "fraction", getElementData(source,"fraction"))
			end
		end
	end
end

function fraction_uninvite()
	-- bodys
end 